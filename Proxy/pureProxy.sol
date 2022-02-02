// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Proxy{
    address public myContract;
    uint public  a = 0;

    constructor(address contractAddress){
        myContract = contractAddress;    
    }



    fallback () external payable {
        // load target contract address to stack
        address targetContract = myContract;
        assembly{
            // https://docs.soliditylang.org/en/v0.8.10/internals/layout_in_memory.html#layout-in-memory
            // get free pointer, initially it should point to 0x80
            let p := mload(0x40)
            // load calldata to memory
            calldatacopy(p, 0, calldatasize())
            mstore(0x40, add(p, calldatasize()))  // move free pointer forward (pointing to 0x80+size)
            // delegatecall to the target contract with the loaded calldata in memory
            let result := delegatecall(gas(), targetContract, 0x80, calldatasize(), 0x0, 0)
            // copy returned value to memory
            returndatacopy(0, 0, returndatasize())
            // check if the delegatecall successed, and revert if it failed
            if iszero(result) { revert(0, returndatasize()) }
            // return whatever returned from the delegatecall
            return(0, returndatasize())
        }
    }

    receive() external payable {}

}