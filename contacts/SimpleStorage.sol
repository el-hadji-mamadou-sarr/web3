// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {

    uint256  favoriteNumber;
    //create a function
    function store(uint256 _favoriteNumber) public  virtual{
        favoriteNumber = _favoriteNumber;
        
    }

    //function that doesn't spend gas view or pure
    //calling a view function is free unless you call in a other function
    function retreive() public view returns(uint256){
        return favoriteNumber;
    }

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People public person = People({favoriteNumber:1, name:"Patrick"});

    People[] public people;

     //map
    mapping(string=>uint256) public nameToFavoriteNumber;

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    //calldata, memory, storage
    //calldata or memory are just data that won't live when the function call is over 
    //and storage stay even the function call is over
    //the difference between calldata and memory is that calldata can't be modified and memory can be modified
    //so we have to put "name" in memory because a string is an array of bytes so an array and we have to specifie it

   

}