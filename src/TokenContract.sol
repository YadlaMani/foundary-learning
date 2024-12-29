// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract TokenContract is ERC20,Ownable { 
    
    constructor(string memory _name,string memory _symbol)ERC20(_name,_symbol)Ownable(msg.sender){
        
       
    }
    function mint(address _to,uint256 _amount)public  onlyOwner {
        _mint(_to,_amount);
    }
    function transfer(address _to,uint256 _amount)public override returns(bool){
        super.transfer(_to,_amount);
        return true;
    }
    
}
