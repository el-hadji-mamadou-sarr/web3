// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// we can use library to do operations on objects
// its like the object has params or functions
library PriceConverter{
      function getPrice() internal view returns(uint256){
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

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice = getPrice();
        //so ethAmount is like *1e18 cause 1eth = 1e18 wei 
        uint256 ethAmountInUsd = (ethPrice * ethAmount) /1e18;

        // so the amount in usd is * by 1e18
        return ethAmountInUsd;
    }

}