// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import "../src/MysteryBox.sol";
import "../src/MysteryBoxMinter.sol";

contract MysteryBoxMinterScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // address USDT = 0x9e5AAC1Ba1a2e6aEd6b32689DFcF62A509Ca96f3;
        // use testnet USDT
        address USDT = 0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684;

        MysteryBoxMinter minter = new MysteryBoxMinter(100 * 1e6, 5000, USDT);
        MysteryBox mysteryBox = minter.mysteryBox();

        console2.log("MysteryBox:", address(mysteryBox));
        console2.log("Minter:", address(minter));
        vm.stopBroadcast();
    }
}
