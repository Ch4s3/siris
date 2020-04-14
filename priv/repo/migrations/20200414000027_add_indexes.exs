defmodule Siris.Repo.Migrations.AddIndexes do
  use Ecto.Migration

  def up do
    execute "CREATE INDEX trgm_idx_hops_variety ON hops USING gin (variety gin_trgm_ops)"
    execute "CREATE INDEX trgm_idx_grains_name ON grains USING gin (name gin_trgm_ops)"
    execute "CREATE INDEX trgm_idx_recipes_name ON recipes USING gin (name gin_trgm_ops)"
  end

  def down do
    execute "DROP INDEX trgm_idx_hops_variety"
    execute "DROP INDEX trgm_idx_grains_name"
    execute "DROP INDEX trgm_idx_recipes_name"
  end
end
