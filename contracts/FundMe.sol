//get fund from users
//withdrw funds
//set minimum funds

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;
    // using constant keyword can make us save gas
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address [] funders;
    mapping (address =>uint256) addressToAmountFunded;

    // as constant immutable is only set 1 time and can't be change
    // its also gas efficient
    address public immutable i_owner;

    // the constructor is the function wich is called when the contract is beaing created
    //so we can at the creation set the owner of the contract to the one publishing it

    constructor (){
        i_owner = msg.sender;
    }

    function fund() public payable{
        //set minimum fund
        //require is the constraint
        //chainlink is to get externet data from the real world
        //vrf random
        //keepers event to triggers
        //chainlink api to get api
        //1eth = 1e18 wei   
        require(msg.value.getConversionRate() >= MINIMUM_USD, "not enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] =  msg.value;
    }

    function withdraw()  public onlyOwner{
      
        //reset
        for(uint256 index; index < funders.length; index++){
            address funder = funders[index];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        //withdraw
        (bool success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "failed to withdraw"); 
        
    }

    // a modifier is a keyword we can create and put it at the head of the function
    // to tell that when we call the function do what is in the modifier first and then do the rest
    // in the exemple we can use the modifier to tell that only the owner of the contract can call the function
    modifier onlyOwner{
        require(msg.sender == i_owner, "sender is not owner");
        _;
    }

    // if someone send ether without specifying the fund method
    receive() external payable {
        fund();
    }

    // if someone send ether with a function that do not exist
    fallback() external payable{
        fund();
    }


}