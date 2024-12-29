// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract BridgeETH is Ownable {
    uint256 public balance;
    address public tokenAddress;
    mapping(address=>uint256) public pendingBalance;
    constructor(address _tokenAddress)Ownable(msg.sender){
        tokenAddress = _tokenAddress;
    }
    function deposit(IERC20 _tokenAddress,uint _amount)public{
        require(address(_tokenAddress)==tokenAddress,"Invalid token address");
        require(_tokenAddress.allowance(msg.sender,address(this))>=_amount,"Check the token allowance");
        require(_tokenAddress.transferFrom(msg.sender,address(this),_amount),"Somethign went wrong while transfer");
        pendingBalance[msg.sender]+=_amount;

    }
    function withdraw(IERC20 _tokenAddress,uint _amount)public{
        require(pendingBalance[msg.sender]>=_amount,"Insufficient balance");
        pendingBalance[msg.sender]-=_amount;
        _tokenAddress.transfer(msg.sender,_amount);
    }

}