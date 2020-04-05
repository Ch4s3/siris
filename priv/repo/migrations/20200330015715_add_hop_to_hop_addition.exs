defmodule Siris.Repo.Migrations.AddHopToHopAddition do
  use Ecto.Migration

  def change do
    alter table(:hop_additions) do
      add :hop_id, references(:hops)
    end
  end
end
