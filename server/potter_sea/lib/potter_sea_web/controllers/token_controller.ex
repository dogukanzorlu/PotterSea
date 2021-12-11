defmodule PotterSeaWeb.TokenController do
  use PotterSeaWeb, :controller

  def index(conn, _params) do
    tokens = Mongo.find(:mongo, "tokens", %{})
    render(conn, "index.json", tokens: tokens)
  end

  def create(conn, %{"token" => token_params}) do
    token = %{
      token_id: "uuid",
      price: token_params["price"],
      ipfs_hash: token_params["ipfs_hash"]

    }

    Mongo.insert_one(:mongo, "tokens", token)
    render(conn, "token.json", token: token)
  end

  def show(conn, %{"id" => id}) do
    token = Mongo.find(:mongo, "tokens", %{token_id: id})
    render(conn, "show.json", token: token)
  end
end
