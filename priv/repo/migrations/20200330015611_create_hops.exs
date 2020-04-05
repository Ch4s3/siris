defmodule Siris.Repo.Migrations.CreateHops do
  use Ecto.Migration

  def change do
    create table(:hops) do
      add :variety, :string
      add :origin, :string
      add :type, :string
      add :aa_low, :float
      add :aa_high, :float
      add :ba_low, :float
      add :ba_high, :float
      add :total_oil_low, :float
      add :total_oil_high, :float
      add :co_humulone_low, :float
      add :co_humulone_high, :float
      add :myrcene_low, :float
      add :myrcene_high, :float
      add :caryophyllene_low, :float
      add :caryophyllene_high, :float
      add :humulene_low, :float
      add :humulene_high, :float
      add :farnesene, :string
      add :description, :string, size: 1024
      add :aroma, :string

      timestamps()
    end

    create unique_index(:hops, [:variety, :origin], name: :hop_varietal_origin)
  end
end
