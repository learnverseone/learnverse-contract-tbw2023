// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

contract MysteryBox is ERC721Enumerable, Pausable, Ownable {
    uint256 private _tokenIdCounter;

    function safeMint(address receiver) public onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(_receiver, tokenId);
        _tokenIdCounter += 1;
    }
}
