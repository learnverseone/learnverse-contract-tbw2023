// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test, console2} from "forge-std/Test.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./MysteryBox.sol";

contract MysteryBoxMinter is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    uint256 public price;
    IERC20 public usdt;

    uint256 public maxSupply;

    MysteryBox public mysteryBox;

    constructor(
        uint256 _price,
        uint256 _maxSupply,
        address usdt_
    ) Ownable(msg.sender) {
        mysteryBox = new MysteryBox(address(this));

        usdt = IERC20(usdt_);

        mysteryBox.setMinter(address(this));

        mysteryBox.setURI(
            "ipfs://QmegScR4J1EXDvMoaEwt5gzMGcvtahoUmMaSsXmbmkNhst/"
        );

        set(_price, _maxSupply);
    }

    function set(uint256 _price, uint256 _maxSupply) public onlyOwner {
        price = _price;
        maxSupply = _maxSupply;
    }

    function mint(address to, uint256 amount) external payable nonReentrant {
        uint256 userBalance = usdt.balanceOf(msg.sender);
        //console2.log("userBalance", userBalance);
        require(userBalance >= amount * price, "not enough usdt");
        require(
            mysteryBox.totalSupply() + amount <= maxSupply,
            "max supply reached"
        );
        usdt.safeIncreaseAllowance(address(this), amount * price);
        //console2.log("allowance", usdt.allowance(msg.sender, address(this)));
        usdt.safeTransferFrom(msg.sender, address(this), amount * price);

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
