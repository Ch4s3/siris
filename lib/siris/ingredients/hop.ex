defmodule Siris.Ingredients.Hop do
  @moduledoc """
  Database module for storing and accessing hops (mostly a lookup table)
  """
  use Ecto.Schema
  import Ecto.Changeset

  @all_fields ~w(variety origin type aa_low aa_high ba_low
                ba_high total_oil_low total_oil_high co_humulone_low
                co_humulone_high myrcene_low myrcene_high
                caryophyllene_low caryophyllene_high
                humulene_low  humulene_high farnesene
                description aroma)a
  schema "hops" do
    field :aa_high, :float
    field :aa_low, :float
    field :aroma, :string
    field :ba_high, :float
    field :ba_low, :float
    field :caryophyllene_high, :float
    field :caryophyllene_low, :float
    field :co_humulone_high, :float
    field :co_humulone_low, :float
    field :description, :string
    field :farnesene, :string
    field :humulene_high, :float
    field :humulene_low, :float
    field :myrcene_high, :float
    field :myrcene_low, :float
    field :origin, :string
    field :total_oil_high, :float
    field :total_oil_low, :float
    field :type, :string
    field :variety, :string

    timestamps()
  end

  @doc false
  def changeset(hop, attrs) do
    hop
    |> cast(attrs, @all_fields)
    |> validate_required([
      :variety,
      :origin,
      :type,
      :aa_low,
      :aa_high,
      :ba_low,
      :ba_high,
      :total_oil_low,
      :total_oil_high
    ])
    |> unique_constraint(:hop_varietal_origin, name: :hop_varietal_origin)
  end
end
