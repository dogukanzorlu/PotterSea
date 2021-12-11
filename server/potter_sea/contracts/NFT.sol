pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    struct Item {
        address creator;
        uint256 itemId;
        uint256 price;
        string url;
    }

    mapping (string=> Item) public Items;
    
    constructor () ERC721("PotterToken", "PT") {}
    
    function mintToken(string memory _uuid, string memory _ipfsHash, uint256 _price) public{
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        Items[_uuid] = Item({
            creator: msg.sender,
            itemId: newItemId,
            price: _price,
            url: _ipfsHash
        });
    }
}