defmodule PotterSeaWeb.TokenController do
  use PotterSeaWeb, :controller

  alias PotterSea.NFT
  alias PotterSea.NFT.Token

  action_fallback PotterSeaWeb.FallbackController

  def index(conn, _params) do
    tokens = NFT.list_tokens()
    render(conn, "index.json", tokens: tokens)
  end

  def create(conn, %{"token" => token_params}) do
    with {:ok, %Token{} = token} <- NFT.create_token(token_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.token_path(conn, :show, token))
      |> render("show.json", token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    token = NFT.get_token!(id)
    render(conn, "show.json", token: token)
  end

  def update(conn, %{"id" => id, "token" => token_params}) do
    token = NFT.get_token!(id)

    with {:ok, %Token{} = token} <- NFT.update_token(token, token_params) do
      render(conn, "show.json", token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    token = NFT.get_token!(id)

    with {:ok, %Token{}} <- NFT.delete_token(token) do
      send_resp(conn, :no_content, "")
    end
  end
end
