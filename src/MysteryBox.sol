// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

contract MysteryBox is ERC721Enumerable, Pausable, Ownable {
    uint256 private _tokenIdCounter;
    address public minter;
    string private baseURI_;

    constructor(
        address initialOwner
    ) Ownable(initialOwner) ERC721("Learnverse: MysteryBox", "BOX") {}

    function setMinter(address _minter) external onlyOwner {
        minter = _minter;
    }

    function setURI(string memory uri) external onlyOwner {
        baseURI_ = uri;
    }

    function mint(address to) external {
        require(msg.sender == minter, "Not minter");

        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _tokenIdCounter += 1;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
