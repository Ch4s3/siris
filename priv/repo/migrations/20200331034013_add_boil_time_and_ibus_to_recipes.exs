defmodule Siris.Repo.Migrations.AddBoilTimeAndIbusToRecipes do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :boil_time, :integer
      add :ibus, :float
      add :batch_size, :float
      add :batch_units, :string
    end
  end
end
