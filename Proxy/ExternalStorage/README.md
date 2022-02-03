# Proxy External Storage 
Store all variables with the same type in a hash map so that the address can be assigned to different slot determined by the formular
https://docs.soliditylang.org/en/v0.8.11/internals/layout_in_storage.html#mappings-and-dynamic-arrays

Note: All the mapping variables are stored in a parent contract, and both myContract and proxy contract should place it at 1st of the inheritance chain.



Implementation from OpenZeppelin
https://github.com/OpenZeppelin/openzeppelin-labs/tree/master/upgradeability_using_eternal_storage


But the implementations are splitted into serval files, so I draw am uml to give an overview.



![External Storage Proxy UML](./proxyParternExternalStorage.png?raw=true "External Storage Proxy UML")