defmodule Siris.Recipes.HopAddition do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Siris.Ingredients.Hop
  alias Siris.Recipes.Recipe

  schema "hop_additions" do
    field :aa_rating, :float
    field :boil_time, :integer
    field :grams, :float
    field :name, :string
    field :ounces, :float
    field :uuid, Ecto.UUID
    belongs_to(:hop, Hop)
    belongs_to(:recipe, Recipe)

    timestamps()
  end

  @doc false
  def changeset(hop_addition, attrs) do
    data = Map.merge(attrs, %{"uuid" => Ecto.UUID.generate()})

    hop_addition
    |> cast(data, [:name, :aa_rating, :ounces, :grams, :boil_time, :uuid, :hop_id, :recipe_id])
    |> validate_required([:name, :aa_rating, :ounces, :boil_time, :uuid, :recipe_id])
  end
end
