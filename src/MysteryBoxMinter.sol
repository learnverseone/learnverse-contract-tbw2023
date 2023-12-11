// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./MysteryBox.sol";

contract MysteryBoxMinter is Ownable, ReentrancyGuard {
    uint256 public price = 100;
    ERC20 public usdt;

    uint256 public maxSupply = 5000;

    MysteryBox public mysteryBox;

    constructor(
        uint256 _price,
        uint256 _maxSupply,
        address usdt_
    ) Ownable(msg.sender) {
        mysteryBox = new MysteryBox(msg.sender);

        usdt = ERC20(usdt_);

        mysteryBox.setMinter(address(this));

        mysteryBox.setURI(
            "ipfs://QmegScR4J1EXDvMoaEwt5gzMGcvtahoUmMaSsXmbmkNhst/"
        );

        mysteryBox.transferOwnership(msg.sender);

        set(_price, _maxSupply);
    }

    function set(uint256 _price, uint256 _maxSupply) public onlyOwner {
        price = _price;
        maxSupply = _maxSupply;
    }

    function mint(address to, uint256 amount) external payable nonReentrant {
        uint256 userBalance = usdt.balanceOf(msg.sender);
        require(userBalance >= amount * price, "not enough usdt");
        require(
            mysteryBox.totalSupply() + amount <= maxSupply,
            "max supply reached"
        );

        usdt.transferFrom(msg.sender, address(this), amount * price);

        for (uint256 i = 0; i < amount; i++) {
            mysteryBox.mint(to);
        }
    }

    function withdrawAll(address to) public onlyOwner {
        usdt.transferFrom(address(this), to, usdt.balanceOf(address(this)));
    }

    receive() external payable {}

    fallback() external payable {}
}
