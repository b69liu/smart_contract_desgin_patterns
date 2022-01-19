// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Satellite + Ralay
 * @dev Similar to Registry but the proxy contract should have similar methods signature
 */
contract MainContract {

    uint256 number;
    ComputeProxy private computeModuleProxy;

    constructor(address _computeModuleProxy){
        require(address(_computeModuleProxy) != address(0x0), "module proxy cannot be empty");
        computeModuleProxy = ComputeProxy(_computeModuleProxy);
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function setNumber(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return magically transformed value of 'number'
     */
    function getTransformedNumber() public view returns (uint256){
        // get the current module when we need to use it
        require(address(computeModuleProxy) != address(0x0), "please set compute module proxy");
        return  computeModuleProxy.getLastFourBits(computeModuleProxy.divideFour(number));
    }


}

contract Compute {

    function divideFour(uint256 num) external pure returns(uint256 result) {
        assembly{
            result := shl(2, num)
        }
    }

    function getLastFourBits(uint256 num) external pure returns(uint256 result) {
        assembly{
            result := and(num, 0xF)
        }
    }

}

contract ComputeProxy{
    address currentModule;
    address private owner;

    constructor(){
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Only owner can call");
        _;
    }

    function updateModule(address newContract) external isOwner{
        currentModule = newContract;
    }

    function divideFour(uint256 num) external view returns(uint256 result) {
        require(address(currentModule) != address(0x0), "please update module");
        Compute compute = Compute(currentModule);
        return compute.divideFour(num);
    }

    function getLastFourBits(uint256 num) external view returns(uint256 result) {
        require(address(currentModule) != address(0x0), "please update module");
        Compute compute = Compute(currentModule);
        return compute.getLastFourBits(num);
    }

}




