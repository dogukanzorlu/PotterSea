defmodule PotterSeaWeb.TokenController do
  use PotterSeaWeb, :controller

  def index(conn, _params) do
    tokens = Mongo.find(:mongo, "tokens", %{})
    render(conn, "index.json", tokens: tokens)
  end

  def create(conn, %{"token" => token_params}) do
    uuid = UUID.uuid1()
    result = GenServer.call(PotterSea.NFT, {:mint, %{uuid: uuid, ipfsHash: token_params["ipfs_hash"], price: token_params["price"]}}, 600_000)

    {:ok, tx} = result[:res]
    account = result[:acc]

    {:ok, encode_metadata} = Jason.decode(token_params["meta_data"])
    token = %{
      token_id: uuid,
      account: account,
      user: token_params["user"],
      price: token_params["price"],
      tx: tx,
      ipfs_hash: token_params["ipfs_hash"],
      meta_data: [encode_metadata]

    }

    Mongo.insert_one(:mongo, "tokens", token)
    render(conn, "token.json", token: token)
  end

  def show(conn, %{"id" => id}) do
    token = Mongo.find(:mongo, "tokens", %{token_id: id})
    render(conn, "show.json", token: token)
  end

  def delete(conn,  %{"id" => id}) do
    Mongo.delete_one(:mongo, "tokens", %{token_id: id})
    tokens = Mongo.find(:mongo, "tokens", %{})
    render(conn, "index.json", tokens: tokens)
  end
end
