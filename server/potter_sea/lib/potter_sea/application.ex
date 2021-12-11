defmodule PotterSea.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    generate_abi_and_bin()
    children = [
      # Start the Telemetry supervisor
      PotterSeaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PotterSea.PubSub},
      # Start the Endpoint (http/https)
      PotterSeaWeb.Endpoint,
      # Start a worker by calling: PotterSea.Worker.start_link(arg)
      {PotterSea.NFT, []},
      {Mongo, [name: :mongo, hostname: "172.17.0.1", database: "pt_db", pool_size: 100, timeout: 600_000, pool_timeout: 600_000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PotterSea.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PotterSeaWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def generate_abi_and_bin do
    {:ok, read_file} = File.read("./abis/NFT.json")
    {:ok, nft_json} = Poison.decode(read_file)
    abi_encode = Poison.encode!(nft_json["abi"])
    File.write("./abis/nft.abi", abi_encode, [:binary])
    File.write("./abis/nft.bin", String.replace(nft_json["bytecode"], "0x", ""))
  end
end
