# Satellite + Registry

## Registry
Register different version of module contracts to the registry contract.
By doing this, we can easily manage all historical versions of modules

## Satellite
Extract the logic to different module contracts.
Whenever we need to the the function in module, we need to get the module from registry and then call its method from module.
