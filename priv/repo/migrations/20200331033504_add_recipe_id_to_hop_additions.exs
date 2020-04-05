defmodule Siris.Repo.Migrations.AddRecipeIdToHopAdditions do
  use Ecto.Migration

  def change do
    alter table(:hop_additions) do
      add :recipe_id, references(:recipes, on_delete: :delete_all)
    end
  end
end
