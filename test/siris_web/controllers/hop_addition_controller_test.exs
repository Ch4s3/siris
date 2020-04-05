defmodule SirisWeb.HopAdditionControllerTest do
  use SirisWeb.ConnCase

  alias Siris.Recipes

  @create_attrs %{
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
  @invalid_attrs %{aa_rating: nil, boil_time: nil, grams: nil, name: nil, ounces: nil, uuid: nil}

  def fixture(:hop_addition) do
    {:ok, hop_addition} = Recipes.create_hop_addition(@create_attrs)
    hop_addition
  end

  describe "index" do
    test "lists all hop_additions", %{conn: conn} do
      conn = get(conn, Routes.hop_addition_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Hop additions"
    end
  end

  describe "new hop_addition" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.hop_addition_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hop addition"
    end
  end

  describe "create hop_addition" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.hop_addition_path(conn, :create), hop_addition: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.hop_addition_path(conn, :show, id)

      conn = get(conn, Routes.hop_addition_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hop addition"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.hop_addition_path(conn, :create), hop_addition: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hop addition"
    end
  end

  describe "edit hop_addition" do
    setup [:create_hop_addition]

    test "renders form for editing chosen hop_addition", %{conn: conn, hop_addition: hop_addition} do
      conn = get(conn, Routes.hop_addition_path(conn, :edit, hop_addition))
      assert html_response(conn, 200) =~ "Edit Hop addition"
    end
  end

  describe "update hop_addition" do
    setup [:create_hop_addition]

    test "redirects when data is valid", %{conn: conn, hop_addition: hop_addition} do
      conn =
        put(conn, Routes.hop_addition_path(conn, :update, hop_addition),
          hop_addition: @update_attrs
        )

      assert redirected_to(conn) == Routes.hop_addition_path(conn, :show, hop_addition)

      conn = get(conn, Routes.hop_addition_path(conn, :show, hop_addition))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, hop_addition: hop_addition} do
      conn =
        put(conn, Routes.hop_addition_path(conn, :update, hop_addition),
          hop_addition: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Hop addition"
    end
  end

  describe "delete hop_addition" do
    setup [:create_hop_addition]

    test "deletes chosen hop_addition", %{conn: conn, hop_addition: hop_addition} do
      conn = delete(conn, Routes.hop_addition_path(conn, :delete, hop_addition))
      assert redirected_to(conn) == Routes.hop_addition_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.hop_addition_path(conn, :show, hop_addition))
      end
    end
  end

  defp create_hop_addition(_) do
    hop_addition = fixture(:hop_addition)
    {:ok, hop_addition: hop_addition}
  end
end
