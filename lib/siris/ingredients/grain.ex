defmodule Siris.Ingredients.Grain do
  @moduledoc """
  Database module for storing and accessing grains (mostly a lookup table)
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "grains" do
    field :description, :string
    field :extract_fg, :float
    field :grain_type, :string
    field :lovibond_high, :float
    field :lovibond_low, :float
    field :manufacturer, :string
    field :max_usage, :float
    field :moisture, :float
    field :must_mash, :boolean, default: false
    field :name, :string
    field :origin, :string
    field :potential, :float
    field :power_high_lintner, :string
    field :protein_total, :float
    field :srm_high, :float
    field :srm_low, :float

    timestamps()
  end

  @doc false
  def changeset(grain, attrs) do
    grain
    |> cast(attrs, [
      :name,
      :origin,
      :grain_type,
      :manufacturer,
      :must_mash,
      :lovibond_low,
      :lovibond_high,
      :srm_low,
      :srm_high,
      :power_high_lintner,
      :protein_total,
      :extract_fg,
      :potential,
      :moisture,
      :max_usage,
      :description
    ])
    |> validate_required([
      :name,
      :manufacturer,
      :origin,
      :grain_type,
      :must_mash,
      :max_usage
    ])
  end
end
