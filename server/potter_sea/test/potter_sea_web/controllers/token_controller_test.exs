defmodule PotterSeaWeb.TokenControllerTest do
  use PotterSeaWeb.ConnCase

  import PotterSea.NFTFixtures

  alias PotterSea.NFT.Token

  @create_attrs %{
    ipfs_hash: "s5ASC2Cxzx58DXx2xzc1",
    price: 12,
    user: "Zafer",
    meta_data: "{}"
  }
  @update_attrs %{

  }
  @invalid_attrs %{
    ipfs_hash: "s5ASC2Cxzx58DXx2xzc1",
    price: 12
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tokens", %{conn: conn} do
      conn = get(conn, Routes.token_path(conn, :index))
      assert response(conn, 200)
    end
  end

  describe "create token" do
    test "renders token when data is valid", %{conn: conn} do
      conn = post(conn, Routes.token_path(conn, :create), token: @create_attrs)
      assert response(conn, 200)
    end
  end

  defp create_token(_) do
    token = token_fixture()
    %{token: token}
  end
end
