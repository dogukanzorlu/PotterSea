defmodule PotterSea.Seeder do
  use Task

  def start_link(_) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    gryffindor()
    slytherin()
  end

  def gryffindor do
    gryffindor_list = File.ls!("./assets/characters/gryffindor")
    {:ok, character_json} = File.read("./assets/characters/gryffindor.json")
    {:ok, character_json_decoded} = Poison.decode(character_json)
    gryffindor_list
    |> Enum.map(fn i ->
      number = String.at(i,0)
      data = Enum.at(character_json_decoded["data"], (String.to_integer(number) - 1))
      {:ok, res} = HTTPoison.post("http://172.17.0.1:5001/api/v0/add", {:multipart, [{:file, "./assets/characters/gryffindor/#{i}"}]})
      decoded = Poison.decode!(res.body)

      token = %{
        token_id: data["token_id"],
        account: data["account"],
        user: data["user"],
        price: data["price"],
        tx: data["tx"],
        ipfs_hash: decoded["Hash"],
        meta_data: [data["meta_data"]]

      }

      Mongo.insert_one(:mongo, "tokens", token)
    end)
  end

  def slytherin do
    slytherin_list = File.ls!("./assets/characters/slytherin")
    {:ok, character_json} = File.read("./assets/characters/slytherin.json")
    {:ok, character_json_decoded} = Poison.decode(character_json)
    slytherin_list
    |> Enum.map(fn i ->
      number = String.at(i,0)
      data = Enum.at(character_json_decoded["data"], (String.to_integer(number) - 1))
      {:ok, res} = HTTPoison.post("http://172.17.0.1:5001/api/v0/add", {:multipart, [{:file, "./assets/characters/slytherin/#{i}"}]})
      decoded = Poison.decode!(res.body)

      token = %{
        token_id: data["token_id"],
        account: data["account"],
        user: data["user"],
        price: data["price"],
        tx: data["tx"],
        ipfs_hash: decoded["Hash"],
        meta_data: [data["meta_data"]]

      }

      Mongo.insert_one(:mongo, "tokens", token)
    end)
  end
end
