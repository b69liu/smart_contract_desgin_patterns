# Proxy Inherited Storage 
If both contracts inherit the same storage contract, the first few storage slots upgrading purposes will be the same in both contract.

Note, the slot order abids by the order in the inheritance list. So when your contract need to inherit other base classes, make sure the other classes are placed after the Upgradable class. https://ethereum.stackexchange.com/a/63404

Implementation from OpenZeppelin
https://github.com/OpenZeppelin/openzeppelin-labs/tree/master/upgradeability_using_inherited_storage


But the implementations are splitted into serval files, so I draw am uml to give an overview.



![Inheritance Proxy UML](./inheritanceProxyPattern.png?raw=true "Inheritance Proxy UML")