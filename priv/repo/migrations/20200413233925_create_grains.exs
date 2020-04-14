defmodule Siris.Repo.Migrations.CreateGrains do
  use Ecto.Migration

  def change do
    create table(:grains) do
      add :name, :text
      add :origin, :text
      add :grain_type, :text
      add :manufacturer, :string
      add :must_mash, :boolean, default: false, null: false
      add :lovibond_low, :float
      add :lovibond_high, :float
      add :srm_low, :float
      add :srm_high, :float
      add :power_high_lintner, :text
      add :protein_total, :float
      add :extract_fg, :float
      add :potential, :float
      add :moisture, :float
      add :max_usage, :float
      add :description, :text

      timestamps()
    end
  end
end
