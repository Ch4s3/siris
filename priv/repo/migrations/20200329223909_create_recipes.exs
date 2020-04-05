defmodule Siris.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :uuid, :uuid

      timestamps()
    end
  end
end
