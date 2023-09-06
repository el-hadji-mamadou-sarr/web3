//get fund from users
//withdrw funds
//set minimum funds

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;
    address [] funders;
    mapping (address =>uint256) addressToAmountFunded;
    address owner;

    // the constructor is the function wich is called when the contract is beaing created
    //so we can at the creation set the owner of the contract to the one publishing it

    constructor (){
        owner = msg.sender;
    }

    function fund() public payable{
        //set minimum fund
        //require is the constraint
        //chainlink is to get externet data from the real world
        //vrf random
        //keepers event to triggers
        //chainlink api to get api
        //1eth = 1e18 wei   
        require(msg.value.getConversionRate() >= minimumUsd, "not enough");
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
        require(msg.sender == owner, "sender is not owner");
        _;
    }

}