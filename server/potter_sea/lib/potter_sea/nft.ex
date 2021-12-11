defmodule PotterSea.NFT do
  @moduledoc """
  The NFT context.
  """

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: PotterSea.NFT)
  end

  def init(_) do
    web3_serv()
    {:ok, nil}
  end

  def handle_call({:mint, arg}, _, state) do
    accounts = ExW3.accounts()
    result = ExW3.Contract.send(:NFT, :mintToken, [arg[:uuid], arg[:ipfsHash], String.to_integer("#{arg[:price]}")], %{from: Enum.at(accounts, 0), gas: 2586796})

    {:reply, %{acc: Enum.at(accounts, 0), res: result}, state}
  end

  def handle_call({:get_token_url, arg}, _, state) do
    result = ExW3.Contract.call(:NFT, :getUrl, [arg])
    {:reply, result, state}
  end

  def web3_serv() do
    accounts = ExW3.accounts()

    first_acc = Enum.at(accounts, 0)
    ExW3.balance(first_acc)
    ExW3.block_number()

    storage_abi = ExW3.Abi.load_abi("./abis/nft.abi")
    storage_bin = ExW3.Abi.load_bin("./abis/nft.bin")

    ExW3.Contract.start_link
    ExW3.Contract.register(:NFT, abi: storage_abi)
    {:ok, address, _} = ExW3.Contract.deploy(:NFT, bin: storage_bin, options: %{gas: 6721975, from: first_acc})
    ExW3.Contract.at(:NFT, address)
  end
end
