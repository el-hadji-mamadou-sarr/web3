// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FallbackExemple {
    uint256 public result;
    // in solidity we have a function that can catch anytime we send something to the contract
    receive() external payable {
        result =1;
    }

    // so the fallback function catch if there is no function with that address in the calldata 
    fallback() external payable {
        result = 2;
    }
}