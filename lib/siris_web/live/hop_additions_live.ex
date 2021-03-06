defmodule SirisWeb.HopAdditionsLive do
  @moduledoc false

  require Logger
  use Phoenix.LiveView
  alias Siris.Ingredients
  alias Siris.Recipes
  alias Siris.Recipes.HopAddition
  import ScoutApm.Tracing

  @timing_opts [category: "Hops"]

  def mount(_params, data, socket) do
    {:ok, fetch(socket, data)}
  end

  @timing_opts [category: "Hops", name: "render"]
  deftiming render(assigns) do
    SirisWeb.HopAdditionView.render("hops.html", assigns)
  end

  @timing_opts [category: "Hops", name: "type-ahead"]
  deftiming handle_event(
              "validate_or_typeahead",
              %{"_target" => ["hop_addition", "name"], "hop_addition" => params},
              socket
            ) do
    hops = Ingredients.find_by(:variety, params["name"])
    next_data = socket.assigns |> Map.merge(%{hops: hops})
    {:noreply, fetch(socket, next_data)}
  end

  @timing_opts [category: "Hops", name: "validate"]
  deftiming handle_event("validate_or_typeahead", %{"hop_addition" => params}, socket) do
    changeset =
      %HopAddition{}
      |> HopAddition.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @timing_opts [category: "Hops", name: "select variety"]
  deftiming handle_event("select_variety", %{"hop-id" => hop_id}, socket) do
    hop_id = String.to_integer(hop_id)

    changeset =
      socket.assigns.changeset
      |> Recipes.add_hop_to_addition(hop_id)

    {:noreply,
     assign(socket, %{
       changeset: changeset,
       hops: []
     })}
  end

  def handle_event("remove_hop", %{"hop-id" => hop_id} = params, socket) do
    hop_id = String.to_integer(hop_id)

    hop_id |> Recipes.get_hop_addition!() |> Recipes.delete_hop_addition()

    next_hops =
      case socket.assigns[:hop_additions] do
        nil ->
          []

        hops ->
          Enum.reject(hops, fn hop -> hop.id == hop_id end)
      end

    {:ok, recipe, _hop_additions} =
      Recipes.update_from_hop_additions(
        nil,
        socket.assigns[:recipe],
        next_hops
      )

    next_data =
      socket.assigns |> Map.replace!(:hop_additions, next_hops) |> Map.replace!(:recipe, recipe)

    {:noreply, fetch(socket, next_data)}
  end

  @timing_opts [category: "Hops", name: "add hops"]
  deftiming handle_event("add_hops", %{"hop_addition" => params}, socket) do
    with cs <- HopAddition.changeset(%HopAddition{}, params),
         cs <- Map.put(cs, :action, :insert),
         {true, cs} <- {cs.valid?, cs},
         {:ok, addition} <- Recipes.create_hop_addition(cs),
         {:ok, recipe, hop_additions} <-
           Recipes.update_from_hop_additions(
             addition,
             socket.assigns[:recipe],
             socket.assigns[:hop_additions]
           ) do
      {:noreply,
       assign(socket, %{
         hop_additions: hop_additions,
         recipe: recipe,
         changeset: Recipes.change_hop_addition(%HopAddition{})
       })}
    else
      {false, cs} ->
        {:noreply, assign(socket, changeset: cs)}
    end
  end

  defp fetch(socket, data) do
    id = data["recipe"]["id"] || data[:recipe].id

    assign(socket, %{
      hop_additions: data[:hop_additions] || Recipes.list_hop_additions(id),
      recipe: data[:recipe] || Recipes.get_recipe!(id),
      changeset: fetch_changes(data),
      hops: data[:hops] || []
    })
  end

  defp fetch_changes(data) do
    data["changeset"] || data[:changeset] || Recipes.change_hop_addition(%HopAddition{})
  end
end
