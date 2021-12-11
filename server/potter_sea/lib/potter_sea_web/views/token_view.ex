defmodule PotterSeaWeb.TokenView do
  use PotterSeaWeb, :view
  alias PotterSeaWeb.TokenView

  defimpl Jason.Encoder, for: BSON.ObjectId do
    def encode(val, _opts \\ []) do
      BSON.ObjectId.encode!(val)
      |> Jason.encode!()
    end
  end

  def render("index.json", %{tokens: tokens}) do
    %{data: render_many(tokens, TokenView, "token.json")}
  end

  def render("show.json", %{token: token}) do
    %{data: render_one(token.docs, TokenView, "token.json")}
  end

  def render("token.json", %{token: token}) do
    token
  end
end
