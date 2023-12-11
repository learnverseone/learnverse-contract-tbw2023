// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import {MysteryBoxMinter} from "../src/MysteryBoxMinter.sol";
import {MysteryBox} from "../src/MysteryBox.sol";

contract MysteryBoxMinterTest is Test {
    using SafeERC20 for IERC20;

    MysteryBoxMinter public minter;
    MysteryBox public mysteryBox;
    address public USDT = 0x9e5AAC1Ba1a2e6aEd6b32689DFcF62A509Ca96f3;
    IERC20 public usdt;

    address public constant alice = address(1);
    address public constant bob = address(2);

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("opbnb"), 10492667);

        // MysteryBox m = new MysteryBox(alice);

        minter = new MysteryBoxMinter(100 * 1e6, 5000, USDT);
        mysteryBox = minter.mysteryBox();
        usdt = IERC20(USDT);
    }

    function testMint() public {
        uint256 amount = 1000 * 1e6;
        deal(USDT, alice, amount);
        assertEq(usdt.balanceOf(alice), amount);

        vm.prank(alice);
        usdt.approve(address(minter), amount);
        vm.prank(alice);
        minter.mint(alice, 2);

        assert(mysteryBox.balanceOf(alice) == 2);
    }
}
