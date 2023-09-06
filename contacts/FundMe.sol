//get fund from users
//withdrw funds
//set minimum funds

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
    contract FundMe{
    uint256 public minimumUsd = 50 * 1e18;
    function fund() public payable{
        //set minimum fund
        //require is the constraint
        //chainlink is to get externet data from the real world
        //vrf random
        //keepers event to triggers
        //chainlink api to get api
        //1eth = 1e18 wei
        require(getConversionRate(msg.value) >= minimumUsd, "not enough"); 
    }

    function getPrice() public view returns(uint256){
        // ABI
        //address ether data feeds 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

          (
            /* uint80 roundID */,
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = pricefeed.latestRoundData();
 
        //so the return here give the price in 8 decimal place means priceUsd*e8
        //so we can leave it like that or we can convert it to 18 decimal place because 1eth = 1e18 wei
        //so to convert it we just have to multiply it by 1e10
        return uint256(price * 1e10) ;
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        //so ethAmount is like *1e18 cause 1eth = 1e18 wei 
        uint256 ethAmountInUsd = (ethPrice * ethAmount) /1e18;

        // so the amount in usd is * by 1e18
        return ethAmountInUsd;
    }

}