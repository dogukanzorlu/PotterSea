defmodule PotterSea.NFTFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PotterSea.NFT` context.
  """

  @doc """
  Generate a token.
  """
  def token_fixture(attrs \\ %{}) do
    {:ok, token} =
      attrs
      |> Enum.into(%{

      })
      |> PotterSea.NFT.create_token()

    token
  end
end
