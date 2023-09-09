// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./SimpleStorage.sol";
//inherite SimpleStorage
contract ExtraStorage is SimpleStorage{
    // +5
    //overading
    //virtual overiding
    // add virtual to the function in the parent and add override in the function of the child
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }

}