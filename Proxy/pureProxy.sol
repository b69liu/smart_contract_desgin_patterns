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
            // load calldata to memory
            calldatacopy(0, 0, calldatasize())
            // delegatecall to the target contract with the loaded calldata in memory
            let result := delegatecall(gas(), targetContract, 0, calldatasize(), 0x0, 0)
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