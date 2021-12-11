defmodule PotterSea.NFTTest do
  use PotterSea.DataCase

  alias PotterSea.NFT

  describe "tokens" do
    alias PotterSea.NFT.Token

    import PotterSea.NFTFixtures

    @invalid_attrs %{}

    test "list_tokens/0 returns all tokens" do
      token = token_fixture()
      assert NFT.list_tokens() == [token]
    end

    test "get_token!/1 returns the token with given id" do
      token = token_fixture()
      assert NFT.get_token!(token.id) == token
    end

    test "create_token/1 with valid data creates a token" do
      valid_attrs = %{}

      assert {:ok, %Token{} = token} = NFT.create_token(valid_attrs)
    end

    test "create_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NFT.create_token(@invalid_attrs)
    end

    test "update_token/2 with valid data updates the token" do
      token = token_fixture()
      update_attrs = %{}

      assert {:ok, %Token{} = token} = NFT.update_token(token, update_attrs)
    end

    test "update_token/2 with invalid data returns error changeset" do
      token = token_fixture()
      assert {:error, %Ecto.Changeset{}} = NFT.update_token(token, @invalid_attrs)
      assert token == NFT.get_token!(token.id)
    end

    test "delete_token/1 deletes the token" do
      token = token_fixture()
      assert {:ok, %Token{}} = NFT.delete_token(token)
      assert_raise Ecto.NoResultsError, fn -> NFT.get_token!(token.id) end
    end

    test "change_token/1 returns a token changeset" do
      token = token_fixture()
      assert %Ecto.Changeset{} = NFT.change_token(token)
    end
  end
end
