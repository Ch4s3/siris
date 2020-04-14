defmodule Siris.IngredientsTest do
  use Siris.DataCase

  alias Siris.Ingredients

  describe "hops" do
    alias Siris.Ingredients.Hop

    @valid_attrs %{
      aa_high: 120.5,
      aa_low: 120.5,
      aroma: "some aroma",
      ba_high: 120.5,
      ba_low: 120.5,
      caryophyllene_high: 120.5,
      caryophyllene_low: 120.5,
      co_humulone_high: 120.5,
      co_humulone_low: 120.5,
      description: "some description",
      farnesene: "some farnesene",
      humulene_high: 120.5,
      humulene_low: 120.5,
      myrcene_high: 120.5,
      myrcene_low: 120.5,
      origin: "some origin",
      total_oil_high: 120.5,
      total_oil_low: 120.5,
      type: "some type",
      variety: "some variety"
    }
    @update_attrs %{
      aa_high: 456.7,
      aa_low: 456.7,
      aroma: "some updated aroma",
      ba_high: 456.7,
      ba_low: 456.7,
      caryophyllene_high: 456.7,
      caryophyllene_low: 456.7,
      co_humulone_high: 456.7,
      co_humulone_low: 456.7,
      description: "some updated description",
      farnesene: "some updated farnesene",
      humulene_high: 456.7,
      humulene_low: 456.7,
      myrcene_high: 456.7,
      myrcene_low: 456.7,
      origin: "some updated origin",
      total_oil_high: 456.7,
      total_oil_low: 456.7,
      type: "some updated type",
      variety: "some updated variety"
    }
    @invalid_attrs %{
      aa_high: nil,
      aa_low: nil,
      aroma: nil,
      ba_high: nil,
      ba_low: nil,
      caryophyllene_high: nil,
      caryophyllene_low: nil,
      co_humulone_high: nil,
      co_humulone_low: nil,
      description: nil,
      farnesene: nil,
      humulene_high: nil,
      humulene_low: nil,
      myrcene_high: nil,
      myrcene_low: nil,
      origin: nil,
      total_oil_high: nil,
      total_oil_low: nil,
      type: nil,
      variety: nil
    }

    def hop_fixture(attrs \\ %{}) do
      {:ok, hop} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ingredients.create_hop()

      hop
    end

    test "list_hops/0 returns all hops" do
      hop = hop_fixture()
      assert Ingredients.list_hops() == [hop]
    end

    test "get_hop!/1 returns the hop with given id" do
      hop = hop_fixture()
      assert Ingredients.get_hop!(hop.id) == hop
    end

    test "create_hop/1 with valid data creates a hop" do
      assert {:ok, %Hop{} = hop} = Ingredients.create_hop(@valid_attrs)
      assert hop.aa_high == 120.5
      assert hop.aa_low == 120.5
      assert hop.aroma == "some aroma"
      assert hop.ba_high == 120.5
      assert hop.ba_low == 120.5
      assert hop.caryophyllene_high == 120.5
      assert hop.caryophyllene_low == 120.5
      assert hop.co_humulone_high == 120.5
      assert hop.co_humulone_low == 120.5
      assert hop.description == "some description"
      assert hop.farnesene == "some farnesene"
      assert hop.humulene_high == 120.5
      assert hop.humulene_low == 120.5
      assert hop.myrcene_high == 120.5
      assert hop.myrcene_low == 120.5
      assert hop.origin == "some origin"
      assert hop.total_oil_high == 120.5
      assert hop.total_oil_low == 120.5
      assert hop.type == "some type"
      assert hop.variety == "some variety"
    end

    test "create_hop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ingredients.create_hop(@invalid_attrs)
    end

    test "update_hop/2 with valid data updates the hop" do
      hop = hop_fixture()
      assert {:ok, %Hop{} = hop} = Ingredients.update_hop(hop, @update_attrs)
      assert hop.aa_high == 456.7
      assert hop.aa_low == 456.7
      assert hop.aroma == "some updated aroma"
      assert hop.ba_high == 456.7
      assert hop.ba_low == 456.7
      assert hop.caryophyllene_high == 456.7
      assert hop.caryophyllene_low == 456.7
      assert hop.co_humulone_high == 456.7
      assert hop.co_humulone_low == 456.7
      assert hop.description == "some updated description"
      assert hop.farnesene == "some updated farnesene"
      assert hop.humulene_high == 456.7
      assert hop.humulene_low == 456.7
      assert hop.myrcene_high == 456.7
      assert hop.myrcene_low == 456.7
      assert hop.origin == "some updated origin"
      assert hop.total_oil_high == 456.7
      assert hop.total_oil_low == 456.7
      assert hop.type == "some updated type"
      assert hop.variety == "some updated variety"
    end

    test "update_hop/2 with invalid data returns error changeset" do
      hop = hop_fixture()
      assert {:error, %Ecto.Changeset{}} = Ingredients.update_hop(hop, @invalid_attrs)
      assert hop == Ingredients.get_hop!(hop.id)
    end

    test "delete_hop/1 deletes the hop" do
      hop = hop_fixture()
      assert {:ok, %Hop{}} = Ingredients.delete_hop(hop)
      assert_raise Ecto.NoResultsError, fn -> Ingredients.get_hop!(hop.id) end
    end

    test "change_hop/1 returns a hop changeset" do
      hop = hop_fixture()
      assert %Ecto.Changeset{} = Ingredients.change_hop(hop)
    end
  end

  describe "grains" do
    alias Siris.Ingredients.Grain

    @valid_attrs %{
      description: "some description",
      extract_fg: 120.5,
      grain_type: "some grain_type",
      lovibond_high: 120.5,
      lovibond_low: 120.5,
      manufacturer: "some manufacturer",
      max_usage: 120.5,
      moisture: 120.5,
      must_mash: true,
      name: "some name",
      origin: "some origin",
      potential: 120.5,
      power_high_lintner: "some power_high_lintner",
      protein_total: 120.5,
      srm_high: 120.5,
      srm_low: 120.5
    }
    @update_attrs %{
      description: "some updated description",
      extract_fg: 456.7,
      grain_type: "some updated grain_type",
      lovibond_high: 456.7,
      lovibond_low: 456.7,
      manufacturer: "some updated manufacturer",
      max_usage: 456.7,
      moisture: 456.7,
      must_mash: false,
      name: "some updated name",
      origin: "some updated origin",
      potential: 456.7,
      power_high_lintner: "some updated power_high_lintner",
      protein_total: 456.7,
      srm_high: 456.7,
      srm_low: 456.7
    }
    @invalid_attrs %{
      description: nil,
      extract_fg: nil,
      grain_type: nil,
      lovibond_high: nil,
      lovibond_low: nil,
      manufacturer: nil,
      max_usage: nil,
      moisture: nil,
      must_mash: nil,
      name: nil,
      origin: nil,
      potential: nil,
      power_high_lintner: nil,
      protein_total: nil,
      srm_high: nil,
      srm_low: nil
    }

    def grain_fixture(attrs \\ %{}) do
      {:ok, grain} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ingredients.create_grain()

      grain
    end

    test "list_grains/0 returns all grains" do
      grain = grain_fixture()
      assert Ingredients.list_grains() == [grain]
    end

    test "get_grain!/1 returns the grain with given id" do
      grain = grain_fixture()
      assert Ingredients.get_grain!(grain.id) == grain
    end

    test "create_grain/1 with valid data creates a grain" do
      assert {:ok, %Grain{} = grain} = Ingredients.create_grain(@valid_attrs)
      assert grain.description == "some description"
      assert grain.extract_fg == 120.5
      assert grain.grain_type == "some grain_type"
      assert grain.lovibond_high == 120.5
      assert grain.lovibond_low == 120.5
      assert grain.manufacturer == "some manufacturer"
      assert grain.max_usage == 120.5
      assert grain.moisture == 120.5
      assert grain.must_mash == true
      assert grain.name == "some name"
      assert grain.origin == "some origin"
      assert grain.potential == 120.5
      assert grain.power_high_lintner == "some power_high_lintner"
      assert grain.protein_total == 120.5
      assert grain.srm_high == 120.5
      assert grain.srm_low == 120.5
    end

    test "create_grain/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ingredients.create_grain(@invalid_attrs)
    end

    test "update_grain/2 with valid data updates the grain" do
      grain = grain_fixture()
      assert {:ok, %Grain{} = grain} = Ingredients.update_grain(grain, @update_attrs)
      assert grain.description == "some updated description"
      assert grain.extract_fg == 456.7
      assert grain.grain_type == "some updated grain_type"
      assert grain.lovibond_high == 456.7
      assert grain.lovibond_low == 456.7
      assert grain.manufacturer == "some updated manufacturer"
      assert grain.max_usage == 456.7
      assert grain.moisture == 456.7
      assert grain.must_mash == false
      assert grain.name == "some updated name"
      assert grain.origin == "some updated origin"
      assert grain.potential == 456.7
      assert grain.power_high_lintner == "some updated power_high_lintner"
      assert grain.protein_total == 456.7
      assert grain.srm_high == 456.7
      assert grain.srm_low == 456.7
    end

    test "update_grain/2 with invalid data returns error changeset" do
      grain = grain_fixture()
      assert {:error, %Ecto.Changeset{}} = Ingredients.update_grain(grain, @invalid_attrs)
      assert grain == Ingredients.get_grain!(grain.id)
    end

    test "delete_grain/1 deletes the grain" do
      grain = grain_fixture()
      assert {:ok, %Grain{}} = Ingredients.delete_grain(grain)
      assert_raise Ecto.NoResultsError, fn -> Ingredients.get_grain!(grain.id) end
    end

    test "change_grain/1 returns a grain changeset" do
      grain = grain_fixture()
      assert %Ecto.Changeset{} = Ingredients.change_grain(grain)
    end
  end
end
