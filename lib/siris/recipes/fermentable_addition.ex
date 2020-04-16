defmodule Siris.Recipes.FermentableAddition do
  use Ecto.Schema
  import Ecto.Changeset
  alias Siris.Ingredients.Grain
  alias Siris.Recipes.Recipe

  schema "fermentable_additions" do
    field :lvibond, :float
    field :name, :string
    field :potential, :float
    field :ppg, :float
    field :uuid, Ecto.UUID
    belongs_to(:recipe, Recipe)
    belongs_to(:grain, Grain)

    timestamps()
  end

  @doc false
  def changeset(fermentable_addition, attrs) do
    fermentable_addition
    |> cast(attrs, [:name, :lvibond, :ppg, :potential, :uuid])
    |> validate_required([:name, :lvibond])
  end
end
