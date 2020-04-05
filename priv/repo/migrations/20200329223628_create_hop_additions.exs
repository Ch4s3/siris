defmodule Siris.Repo.Migrations.CreateHopAdditions do
  use Ecto.Migration

  def change do
    create table(:hop_additions) do
      add :name, :string
      add :aa_rating, :float
      add :ounces, :float
      add :grams, :float
      add :boil_time, :integer
      add :uuid, :uuid

      timestamps()
    end
  end
end
