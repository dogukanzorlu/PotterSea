defmodule PotterSea.NFT do
  @moduledoc """
  The NFT context.
  """

  import Ecto.Query, warn: false
  alias PotterSea.Repo

  alias PotterSea.NFT.Token

  @doc """
  Returns the list of tokens.

  ## Examples

      iex> list_tokens()
      [%Token{}, ...]

  """
  def list_tokens do
    raise "TODO"
  end

  @doc """
  Gets a single token.

  Raises if the Token does not exist.

  ## Examples

      iex> get_token!(123)
      %Token{}

  """
  def get_token!(id), do: raise "TODO"

  @doc """
  Creates a token.

  ## Examples

      iex> create_token(%{field: value})
      {:ok, %Token{}}

      iex> create_token(%{field: bad_value})
      {:error, ...}

  """
  def create_token(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a token.

  ## Examples

      iex> update_token(token, %{field: new_value})
      {:ok, %Token{}}

      iex> update_token(token, %{field: bad_value})
      {:error, ...}

  """
  def update_token(%Token{} = token, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Token.

  ## Examples

      iex> delete_token(token)
      {:ok, %Token{}}

      iex> delete_token(token)
      {:error, ...}

  """
  def delete_token(%Token{} = token) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking token changes.

  ## Examples

      iex> change_token(token)
      %Todo{...}

  """
  def change_token(%Token{} = token, _attrs \\ %{}) do
    raise "TODO"
  end
end
