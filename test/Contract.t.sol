// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


import "forge-std/Test.sol";
import "../src/TokenContract.sol";


contract TestTokenContract is Test {
    TokenContract token;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner,address indexed spender,uint256 val);

    function setUp() public {
        token = new TokenContract("Mani","MAI");
    }
    function testTransferEmit() public{
        token.mint(address(this),100);
        vm.expectEmit(true,true,false,true);
        emit Transfer(address(this),0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87,10);
        token.transfer(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87,10);
    }
    function testExpectEmitApprove() public{
        token.mint(address(this),100);
        vm.expectEmit(true,true,false,true);
        emit Approval(address(this),0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87,10);
        token.approve(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87,10);
        vm.prank(0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87);
        token.transferFrom(address(this),0xF201248A5433094D3DC9457066Fb5Ad96aD0BF87,10);
        assertEq(token.balanceOf(address(this)),90);

    }

    
    
}
