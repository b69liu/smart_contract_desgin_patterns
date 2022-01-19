// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Data Segregation
 * @dev Seperate the storage and logic
 */
contract Storage {

    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function setNumber(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function getNumber() public view returns (uint256){
        return number;
    }
}

contract Compute {
    Storage store;

    constructor(Storage _store){
        store = _store;
    }

    function increment() public {
        store.setNumber(store.getNumber() + 1);
    }

    function getNumber() public view returns(uint256){
        return store.getNumber();
    }

}




