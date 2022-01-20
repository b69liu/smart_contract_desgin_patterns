# Proxy Pattern

The main idea is to use one proxy contract to delegate call to our contract, so when we need the update our contract, the proxy contract and its address will be the same. However, the delegate call will be using the proxy contract's storage. There are few methods to handle this.

1. [Inherited Storage](./inheritedStorage/README.md) 