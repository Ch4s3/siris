defmodule Siris.Repo.Migrations.CreateFermentableAdditions do
  use Ecto.Migration

  def change do
    create table(:fermentable_additions) do
      add :name, :string
      add :lvibond, :float
      add :ppg, :float
      add :potential, :float
      add :uuid, :uuid
      add :recipe_id, references(:recipes, on_delete: :nothing)
      add :grain_id, references(:grains, on_delete: :nothing)

      timestamps()
    end

    create index(:fermentable_additions, [:recipe_id])
    create index(:fermentable_additions, [:grain_id])
  end
end
