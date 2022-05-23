//SPDX-License-Identifier: MIT
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string _baseTokenURI;

    uint256 public _price = 0.01 ether;

    // _paused is used to pause the contract in case of an emergency
    bool public _paused;

    // Max number of nfts
    uint256 public constant maxTokenIds = 10;

    // total number of tokenIds minted
    uint256 public tokenIds;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor(string memory baseURI) ERC721("LW3Punks", "LW3P") {
        _baseTokenURI = baseURI;
    }

    /**
    * @dev mint allows an user to mint 1 NFT per transaction.
    */
    function mint() public payable onlyWhenNotPaused {
        require(tokenIds < maxTokenIds, "Exceeds maximum LW3PToken");
        require(msg.value >= _price, "ether sent is not correct");
        tokenIds++;
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 balance = address(this).balance;
        (bool sent, ) = _owner.call{value: balance}("");
        require(sent, "Failed to send Ether");
    }

    fallback() external payable {}

    receive() external payable {}
}