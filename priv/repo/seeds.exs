# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Siris.Repo.insert!(%Siris.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#  SeedFns.get_data(:grains, "priv/repo/seed_data/grains.csv")
defmodule SeedFns do
  alias Siris.Ingredients

  def get_data(data_type, path) do
    # File.stream!("priv/repo/seed_data/hops.csv")
    # File.stream!("../lib/siris-0.1.0/priv/repo/seed_data/hops.csv")
    File.stream!(path)
    |> CSV.decode!(headers: true)
    |> insert_data(data_type)
  end

  def insert_data(rows, :hops), do: insert_each_hop(rows)
  def insert_data(rows, :grains), do: insert_each_grain(rows)

  def insert_each_hop(rows) do
    rows |> Enum.map(&insert_hop(&1))
  end

  def insert_each_grain(rows) do
    rows |> Enum.map(&insert_grain(&1))
  end

  def insert_grain(g) do
    data = %{
      description: fetch(g, "Description"),
      extract_fg: fetch(g, "Extract FG Min"),
      grain_type: fetch(g, "Type"),
      lovibond_high: fetch(g, "Color High (Lovibond)"),
      lovibond_low: fetch(g, "Color Low (Lovibond)"),
      manufacturer: fetch(g, "Manufacturer"),
      max_usage: fetch(g, "Usage Max"),
      moisture: fetch(g, "% Moisture"),
      must_mash: fetch(g, "Must Mash?"),
      name: fetch(g, "Grain"),
      origin: fetch(g, "Origin"),
      potential: fetch(g, "Potential"),
      power_high_lintner: fetch(g, "Power High - Lintner"),
      protein_total: fetch(g, "Protein Total"),
      srm_high: fetch(g, "Color High (SRM)"),
      srm_low: fetch(g, "Color Low (SRM)")
    }

    data
    |> Ingredients.create_grain()
    |> case do
      {:error, error} -> IO.inspect(error)
      _ -> nil
    end
  end

  def insert_hop(h) do
    data = %{
      aa_high: fetch(h, "Alpha Acid HIGH (%)"),
      aa_low: fetch(h, "Alpha Acid LOW (%)"),
      aroma: fetch(h, "Aroma (ychhops.com)"),
      ba_high: fetch(h, "Beta Acid HIGH (%)"),
      ba_low: fetch(h, "Beta Acid LOW (%)"),
      caryophyllene_high: fetch(h, "Caryophyllene HIGH (% of total oil)"),
      caryophyllene_low: fetch(h, "Caryophyllene LOW (% of total oil)"),
      co_humulone_high: fetch(h, "Co-Humulone HIGH (%)"),
      co_humulone_low: fetch(h, "Co-Humulone LOW (%)"),
      description: fetch(h, "Description (ychhops.com)"),
      farnesene: fetch(h, "Farnesene (% of total oil)"),
      humulene_high: fetch(h, "Humulene HIGH (% of total oil)"),
      humulene_low: fetch(h, "Humulene LOW (% of total oil)"),
      myrcene_high: fetch(h, "Myrcene HIGH (% of total oil)"),
      myrcene_low: fetch(h, "Myrcene LOW (% of total oil)"),
      origin: fetch(h, "Origin"),
      total_oil_high: fetch(h, "Total Oil HIGH (mL/100g)"),
      total_oil_low: fetch(h, "Total Oil LOW (mL/100g)"),
      type: fetch(h, "Type"),
      variety: fetch(h, "Variety")
    }

    data
    |> Ingredients.create_hop()
    |> case do
      {:error, error} -> IO.inspect(error)
      _ -> nil
    end
  end

  defp fetch(map, name) do
    val = Map.get(map, name)

    val
    |> empty?
    |> case do
      true -> nil
      false -> val
    end
    |> maybe_transform()
  end

  defp maybe_transform(nil), do: nil
  defp maybe_transform("Yes"), do: true
  defp maybe_transform("No"), do: false
  defp maybe_transform(val), do: String.trim(val)
  defp empty?(nil), do: true
  defp empty?(val), do: String.trim(val) == ""
end
