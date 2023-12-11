// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {MysteryBoxMinter} from "../src/MysteryBoxMinter.sol";
import {MysteryBox} from "../src/MysteryBox.sol";

contract MysteryBoxMinterTest is Test {
    MysteryBoxMinter public minter;
    MysteryBox public mysteryBox;
    address public USDT = 0x9e5AAC1Ba1a2e6aEd6b32689DFcF62A509Ca96f3;
    IERC20 public usdt;

    address public constant alice = address(1);
    address public constant bob = address(2);

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("opbnb"), 10492667);

        // minter = new MysteryBoxMinter(100, 5000, USDT);
        // mysteryBox = minter.mysteryBox();
        usdt = IERC20(USDT);
    }

    function testMint() public {
        deal(USDT, alice, 1000 * 1e6);
        assertEq(usdt.balanceOf(alice), 1000 * 1e6);
        console2.log(usdt.balanceOf(alice));
        // vm.prank(alice);
        // minter.mint(alice, 2);
        // assert(mysteryBox.balanceOf(alice) == 2);
    }
}
