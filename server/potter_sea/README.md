# PotterSea
## Üçbüyücü turnuvasına özel,  Harry Potter temalı, dünyanın ilk Elixir backend'i ile geliştirilmiş 3D MetaVerse NFT Marketplace'i.

# İçindekiler

* [Server](#server)
    * [Backend - Stack](#backend-stack)
* [Client](#client)
    * [Client - Stack](#client-stack)
* [Kurulum](#kurulum)

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


### Client-Stack

## Kurulum

Paket bağımlılıkları, birden fazla image ile docker'ın ayağı kalkması internet hızınıza da bağlı olarak 15 dk'yı bulabilmektedir.

```sh
cd PotterSea/docker
sudo docker-compose up -d
```

- [Client] - localhost:
- [Server] - localhost:4000
- [Ganache Server] - localhost:8545
- [IPFS API] - localhost:5001
- [IPFS Client] - localhost:8080
