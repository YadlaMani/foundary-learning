// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BridgeETH.sol";
import "../src/USDT.sol";
contract BridgeEth is Test{
    event Transfer(address indexed from,address indexed to,uint256 val);
    BridgeETH bridge;
    USDT usdt;
    function setUp() public{
        usdt=new USDT();
        bridge=new BridgeETH(address(usdt));

    }
    function test_Deposit() public{
        usdt.mint(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87,200);
        vm.startPrank(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87);
        usdt.approve(address(bridge),200);
        bridge.deposit(usdt,200);
        assertEq(usdt.balanceOf(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87),0);
        assertEq(usdt.balanceOf(address(bridge)),200);
        bridge.withdraw(usdt,100);
        assertEq(usdt.balanceOf(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87),100);
        assertEq(usdt.balanceOf(address(bridge)),100);
    }
}