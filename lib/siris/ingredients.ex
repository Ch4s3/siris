defmodule Siris.Ingredients do
  @moduledoc """
  The Ingredients context.
  """

  import Ecto.Query, warn: false
  alias Siris.Repo

  alias Siris.Ingredients.Hop

  @doc """
  Returns the list of hops.

  ## Examples

      iex> list_hops()
      [%Hop{}, ...]

  """
  def list_hops do
    Repo.all(Hop)
  end

  def find_by(_, search) when search == "", do: []

  def find_by(:variety, search) do
    like = "%#{search}%"

    from(h in Hop,
      where: ilike(h.variety, ^like)
    )
    |> Repo.all()
  end

  def find_by(:origin, search) do
    like = "#{search}%"

    from(h in Hop,
      where: ilike(h.origin, ^like)
    )
    |> Repo.all()
  end

  def find_by(:description, search) do
    like = "%#{search}%"

    from(h in Hop,
      where: ilike(h.description, ^like)
    )
    |> Repo.all()
  end

  def find_by(:aroma, search) do
    like = "%#{search}%"

    from(h in Hop,
      where: ilike(h.aroma, ^like)
    )
    |> Repo.all()
  end

  def aroma_hops do
    Hop |> where(type: "Aroma") |> Repo.all()
  end

  def bittering_hops do
    Hop |> where(type: "Bittering") |> Repo.all()
  end

  def dual_purpose_hops do
    Hop |> where(type: "Dual Purpose") |> Repo.all()
  end

  @doc """
  Gets a single hop.

  Raises `Ecto.NoResultsError` if the Hop does not exist.

  ## Examples

      iex> get_hop!(123)
      %Hop{}

      iex> get_hop!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hop!(id), do: Repo.get!(Hop, id)

  @doc """
  Creates a hop.

  ## Examples

      iex> create_hop(%{field: value})
      {:ok, %Hop{}}

      iex> create_hop(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hop(attrs \\ %{}) do
    %Hop{}
    |> Hop.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hop.

  ## Examples

      iex> update_hop(hop, %{field: new_value})
      {:ok, %Hop{}}

      iex> update_hop(hop, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hop(%Hop{} = hop, attrs) do
    hop
    |> Hop.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hop.

  ## Examples

      iex> delete_hop(hop)
      {:ok, %Hop{}}

      iex> delete_hop(hop)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hop(%Hop{} = hop) do
    Repo.delete(hop)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hop changes.

  ## Examples

      iex> change_hop(hop)
      %Ecto.Changeset{source: %Hop{}}

  """
  def change_hop(%Hop{} = hop) do
    Hop.changeset(hop, %{})
  end
end
