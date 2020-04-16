defmodule Siris.RecipesTest do
  use Siris.DataCase

  alias Siris.Recipes

  describe "hop_additions" do
    alias Siris.Recipes.HopAddition

    @valid_attrs %{
      aa_rating: 120.5,
      boil_time: 42,
      grams: 120.5,
      name: "some name",
      ounces: 120.5,
      uuid: "7488a646-e31f-11e4-aace-600308960662"
    }
    @update_attrs %{
      aa_rating: 456.7,
      boil_time: 43,
      grams: 456.7,
      name: "some updated name",
      ounces: 456.7,
      uuid: "7488a646-e31f-11e4-aace-600308960668"
    }
    @invalid_attrs %{
      aa_rating: nil,
      boil_time: nil,
      grams: nil,
      name: nil,
      ounces: nil,
      uuid: nil
    }

    def hop_addition_fixture(attrs \\ %{}) do
      {:ok, hop_addition} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_hop_addition()

      hop_addition
    end

    test "list_hop_additions/0 returns all hop_additions" do
      hop_addition = hop_addition_fixture()
      assert Recipes.list_hop_additions() == [hop_addition]
    end

    test "get_hop_addition!/1 returns the hop_addition with given id" do
      hop_addition = hop_addition_fixture()
      assert Recipes.get_hop_addition!(hop_addition.id) == hop_addition
    end

    test "create_hop_addition/1 with valid data creates a hop_addition" do
      assert {:ok, %HopAddition{} = hop_addition} = Recipes.create_hop_addition(@valid_attrs)
      assert hop_addition.aa_rating == 120.5
      assert hop_addition.boil_time == 42
      assert hop_addition.grams == 120.5
      assert hop_addition.name == "some name"
      assert hop_addition.ounces == 120.5
      assert hop_addition.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_hop_addition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_hop_addition(@invalid_attrs)
    end

    test "update_hop_addition/2 with valid data updates the hop_addition" do
      hop_addition = hop_addition_fixture()

      assert {:ok, %HopAddition{} = hop_addition} =
               Recipes.update_hop_addition(hop_addition, @update_attrs)

      assert hop_addition.aa_rating == 456.7
      assert hop_addition.boil_time == 43
      assert hop_addition.grams == 456.7
      assert hop_addition.name == "some updated name"
      assert hop_addition.ounces == 456.7
      assert hop_addition.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_hop_addition/2 with invalid data returns error changeset" do
      hop_addition = hop_addition_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Recipes.update_hop_addition(hop_addition, @invalid_attrs)

      assert hop_addition == Recipes.get_hop_addition!(hop_addition.id)
    end

    test "delete_hop_addition/1 deletes the hop_addition" do
      hop_addition = hop_addition_fixture()
      assert {:ok, %HopAddition{}} = Recipes.delete_hop_addition(hop_addition)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_hop_addition!(hop_addition.id) end
    end

    test "change_hop_addition/1 returns a hop_addition changeset" do
      hop_addition = hop_addition_fixture()
      assert %Ecto.Changeset{} = Recipes.change_hop_addition(hop_addition)
    end
  end

  describe "recipes" do
    alias Siris.Recipes.Recipe

    @valid_attrs %{name: "some name", uuid: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{name: "some updated name", uuid: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{name: nil, uuid: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(@valid_attrs)
      assert recipe.name == "some name"
      assert recipe.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, @update_attrs)
      assert recipe.name == "some updated name"
      assert recipe.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end

  describe "fermentable_additions" do
    alias Siris.Recipes.FermentableAddition

    @valid_attrs %{lvibond: 120.5, name: "some name", potential: 120.5, ppg: 120.5, uuid: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{lvibond: 456.7, name: "some updated name", potential: 456.7, ppg: 456.7, uuid: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{lvibond: nil, name: nil, potential: nil, ppg: nil, uuid: nil}

    def fermentable_addition_fixture(attrs \\ %{}) do
      {:ok, fermentable_addition} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_fermentable_addition()

      fermentable_addition
    end

    test "list_fermentable_additions/0 returns all fermentable_additions" do
      fermentable_addition = fermentable_addition_fixture()
      assert Recipes.list_fermentable_additions() == [fermentable_addition]
    end

    test "get_fermentable_addition!/1 returns the fermentable_addition with given id" do
      fermentable_addition = fermentable_addition_fixture()
      assert Recipes.get_fermentable_addition!(fermentable_addition.id) == fermentable_addition
    end

    test "create_fermentable_addition/1 with valid data creates a fermentable_addition" do
      assert {:ok, %FermentableAddition{} = fermentable_addition} = Recipes.create_fermentable_addition(@valid_attrs)
      assert fermentable_addition.lvibond == 120.5
      assert fermentable_addition.name == "some name"
      assert fermentable_addition.potential == 120.5
      assert fermentable_addition.ppg == 120.5
      assert fermentable_addition.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_fermentable_addition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_fermentable_addition(@invalid_attrs)
    end

    test "update_fermentable_addition/2 with valid data updates the fermentable_addition" do
      fermentable_addition = fermentable_addition_fixture()
      assert {:ok, %FermentableAddition{} = fermentable_addition} = Recipes.update_fermentable_addition(fermentable_addition, @update_attrs)
      assert fermentable_addition.lvibond == 456.7
      assert fermentable_addition.name == "some updated name"
      assert fermentable_addition.potential == 456.7
      assert fermentable_addition.ppg == 456.7
      assert fermentable_addition.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_fermentable_addition/2 with invalid data returns error changeset" do
      fermentable_addition = fermentable_addition_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_fermentable_addition(fermentable_addition, @invalid_attrs)
      assert fermentable_addition == Recipes.get_fermentable_addition!(fermentable_addition.id)
    end

    test "delete_fermentable_addition/1 deletes the fermentable_addition" do
      fermentable_addition = fermentable_addition_fixture()
      assert {:ok, %FermentableAddition{}} = Recipes.delete_fermentable_addition(fermentable_addition)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_fermentable_addition!(fermentable_addition.id) end
    end

    test "change_fermentable_addition/1 returns a fermentable_addition changeset" do
      fermentable_addition = fermentable_addition_fixture()
      assert %Ecto.Changeset{} = Recipes.change_fermentable_addition(fermentable_addition)
    end
  end
end
