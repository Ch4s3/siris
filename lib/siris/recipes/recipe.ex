defmodule Siris.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Siris.Recipes.HopAddition

  schema "recipes" do
    field :name, :string
    field :uuid, Ecto.UUID
    field :boil_time, :integer
    field :ibus, :float
    field :batch_size, :float
    field :batch_units, :string
    has_many(:hop_additions, HopAddition)

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    data = Map.merge(attrs, %{"uuid" => Ecto.UUID.generate()})

    recipe
    |> cast(data, [:name, :uuid, :boil_time, :ibus, :batch_size, :batch_units])
    |> validate_required([:name, :uuid])
  end
end
