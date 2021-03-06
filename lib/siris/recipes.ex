defmodule Siris.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias Siris.Formulas.Ibu
  alias Siris.Ingredients
  alias Siris.Recipes.HopAddition
  alias Siris.Repo

  @doc """
  Returns the list of hop_additions.

  """
  def list_hop_additions(id) do
    HopAddition
    |> where([h], h.recipe_id == ^id)
    |> Repo.all()
  end

  @doc """
  Gets a single hop_addition.

  Raises `Ecto.NoResultsError` if the Hop addition does not exist.

  ## Examples

      iex> get_hop_addition!(123)
      %HopAddition{}

      iex> get_hop_addition!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hop_addition!(id), do: Repo.get!(HopAddition, id)

  @doc """
  Creates a hop_addition.

  ## Examples

      iex> create_hop_addition(%{field: value})
      {:ok, %HopAddition{}}

      iex> create_hop_addition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hop_addition(%Ecto.Changeset{} = changes), do: Repo.insert(changes)

  def create_hop_addition(attrs) do
    %HopAddition{}
    |> HopAddition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hop_addition.

  ## Examples

      iex> update_hop_addition(hop_addition, %{field: new_value})
      {:ok, %HopAddition{}}

      iex> update_hop_addition(hop_addition, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hop_addition(%HopAddition{} = hop_addition, attrs) do
    hop_addition
    |> HopAddition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hop_addition.

  ## Examples

      iex> delete_hop_addition(hop_addition)
      {:ok, %HopAddition{}}

      iex> delete_hop_addition(hop_addition)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hop_addition(%HopAddition{} = hop_addition) do
    Repo.delete(hop_addition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hop_addition changes.

  ## Examples

      iex> change_hop_addition(hop_addition)
      %Ecto.Changeset{source: %HopAddition{}}

  """
  def change_hop_addition(%HopAddition{} = hop_addition) do
    HopAddition.changeset(hop_addition, %{})
  end

  alias Siris.Recipes.Recipe

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Repo.all(Recipe)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id), do: Repo.get!(Recipe, id)

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  def add_hop_to_addition(changeset, hop_id) do
    hop = Ingredients.get_hop!(hop_id)

    changeset
    |> Changeset.put_change(:hop, hop)
    |> Changeset.put_change(:name, hop.variety)
    |> Changeset.put_change(:aa_rating, avg_aa_rating(hop))
  end

  defp avg_aa_rating(hop) do
    (hop.aa_high + hop.aa_low) / 2
  end

  @doc """
  Updates Recipe with a `HopAddition`
  """
  def update_from_hop_additions(nil, recipe, additions) do
    ibus = Ibu.calculate(additions, recipe.batch_size, 1.060)
    {:ok, updated_recipe} = recipe |> update_recipe(%{"ibus" => ibus})

    {:ok, updated_recipe, additions}
  end

  def update_from_hop_additions(addition, recipe, additions) do
    hop_additions = [addition | additions]
    ibus = Ibu.calculate(hop_additions, recipe.batch_size, 1.060)
    {:ok, updated_recipe} = recipe |> update_recipe(%{"ibus" => ibus})

    {:ok, updated_recipe, hop_additions}
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end

  alias Siris.Recipes.FermentableAddition

  @doc """
  Returns the list of fermentable_additions.

  ## Examples

      iex> list_fermentable_additions()
      [%FermentableAddition{}, ...]

  """
  def list_fermentable_additions do
    Repo.all(FermentableAddition)
  end

  @doc """
  Gets a single fermentable_addition.

  Raises `Ecto.NoResultsError` if the Fermentable addition does not exist.

  ## Examples

      iex> get_fermentable_addition!(123)
      %FermentableAddition{}

      iex> get_fermentable_addition!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fermentable_addition!(id), do: Repo.get!(FermentableAddition, id)

  @doc """
  Creates a fermentable_addition.

  ## Examples

      iex> create_fermentable_addition(%{field: value})
      {:ok, %FermentableAddition{}}

      iex> create_fermentable_addition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fermentable_addition(attrs \\ %{}) do
    %FermentableAddition{}
    |> FermentableAddition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fermentable_addition.

  ## Examples

      iex> update_fermentable_addition(fermentable_addition, %{field: new_value})
      {:ok, %FermentableAddition{}}

      iex> update_fermentable_addition(fermentable_addition, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fermentable_addition(%FermentableAddition{} = fermentable_addition, attrs) do
    fermentable_addition
    |> FermentableAddition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fermentable_addition.

  ## Examples

      iex> delete_fermentable_addition(fermentable_addition)
      {:ok, %FermentableAddition{}}

      iex> delete_fermentable_addition(fermentable_addition)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fermentable_addition(%FermentableAddition{} = fermentable_addition) do
    Repo.delete(fermentable_addition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fermentable_addition changes.

  ## Examples

      iex> change_fermentable_addition(fermentable_addition)
      %Ecto.Changeset{source: %FermentableAddition{}}

  """
  def change_fermentable_addition(%FermentableAddition{} = fermentable_addition) do
    FermentableAddition.changeset(fermentable_addition, %{})
  end
end
