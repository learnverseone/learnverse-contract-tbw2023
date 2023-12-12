// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/MysteryBox.sol";
import "../src/MysteryBoxMinter.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MysteryBoxMinterScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // address USDT = 0x9e5AAC1Ba1a2e6aEd6b32689DFcF62A509Ca96f3;
        // use opbnb testnet USDT
        address USDT = 0xCF712f20c85421d00EAa1B6F6545AaEEb4492B75;

        MysteryBoxMinter minter = new MysteryBoxMinter(1, 5000, USDT); // lower the price since the faucet only give me 10USDT per 24 hour...
        MysteryBox mysteryBox = minter.mysteryBox();

        console2.log("MysteryBox:", address(mysteryBox));
        console2.log("Minter:", address(minter));

        vm.stopBroadcast();

        vm.startBroadcast(deployerPrivateKey);

        IERC20(USDT).approve(address(minter), 1000);
        minter.mint(msg.sender, 1);

        vm.stopBroadcast();

        vm.startBroadcast(deployerPrivateKey);

        IERC20(USDT).approve(address(minter), 1000);
        minter.mint(msg.sender, 1);

        vm.stopBroadcast();
    }
}
