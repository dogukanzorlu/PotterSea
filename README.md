# PotterSea
## Üçbüyücü turnuvasına özel,  Harry Potter temalı, dünyanın ilk Elixir backend'i ile geliştirilmiş 3D MetaVerse NFT Marketplace'i.

<p align="center">
  <img style="float: right;" src="/pottersea.png" alt="Vim-go logo"/>
</p>

# İçindekiler

* [Server](#server)
    * [Backend - Stack](#backend-stack)
* [Client](#client)
    * [Client - Stack](#client-stack)
* [Kurulum](#kurulum)
* [Test](#test)

## Server
Solidity ile geliştirilmiş olan smart contractlar aracağılı ile üretmiş olduğunuz herhangi bir şey'i mintler. Üretilen NFT'i yi tekrar client'a sunar. Ethereum server ile iletişimi API içinde ki Rustla yazılmış NIF'ler aracılığı ile gerçekleştirir.

### Backend-Stack
- [Elixir] - Ana Çatı API
- [Rust] - Eth server ile iletişimi sağlayan Native Functions
- [Solidity] - Yüklenen şeyin  bir NFT'ye dönüşmesini sağlayan Smart Contracts.
- [MongoDb] - Mintlenen her token'ın metadatası mongo'da tutulur.
- [Ganache] - Eth server
- [Truffle] - Smart Contract Migrations
- [IPFS] - Mintlenen data ipfs de tutulur.

## Client
[`Client Main Repo`](https://github.com/ozcanzaferayan/meta-nft-vr-client)


### Client-Stack

## Kurulum
Localinizde hali hazırda mongodb yüklüyse port çakışmasını önlemek için kapatmalısınız.
#### Linux için

```sh
sudo systemctl stop mongod
```
#### Mac için
```sh
brew services stop mongodb-community
```
### Server Kurulum
Paket bağımlılıkları, birden fazla image ile docker'ın ayağı kalkması internet hızınıza da bağlı olarak 15 dk'yı bulabilmektedir.
Docker image ayağa kalktıktan sonra npm paketleri ve elixir paketlerinin compile olmasını beklemelisiniz!

```sh
cd PotterSea/docker
sudo docker-compose up -d
```

### Client Kurulum

```sh
cd client
sudo docker-compose up -d
```

- [Client] - localhost:1001
- [Server] - localhost:4000
- [Ganache Server] - localhost:8545
- [IPFS API] - localhost:5001
- [IPFS Client] - localhost:8080

## Test

### API test
```sh
sudo docker exec -it docker_backend_1 /bin/bash
root> mix test test/test/potter_sea_web/controllers/token_controller_test.exs
```
### Contract test
```sh
sudo docker exec -it docker_backend_1 /bin/bash
root> truffle test
```

### Zafer AYAN - Doğukan Zorlu
### Teknasyon
