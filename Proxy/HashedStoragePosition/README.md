# Proxy Hashed Storage Position

The main problem for delegate call is that the contract address will store in the first storage slot which will conflict with our own storage variables. To handle this problem, we can store the contract address somewhere else. The given implementation stores the contract implementation address in keccak256("org.zeppelinos.proxy.implemtation").

So when we need to access the implementation address, we need to use yul to load it to the stack or memory. It is like a pointer in c++, and we assign a random address to the pointer.

```
// asign ptr to a hashed address
bytes32 private constant implementationPosition = keccak256("org.zeppelinos.proxy.implementation");

// store the new address to storage[ptr]
bytes32 position = implementationPosition;
assembly {
    sstore(position, newcontractAddress)
}

// read the value from storage[ptr]
bytes32 position = implementationPosition;
assembly {
    implementationAddress := sload(position)
}

```




Implementation from OpenZeppelin
https://github.com/OpenZeppelin/openzeppelin-labs/tree/master/upgradeability_using_unstructured_storage



![Hashed Storage Position Proxy UML](proxyParternHashedStoragePosition.png?raw=true "Hashed Storage Position Proxy UML")