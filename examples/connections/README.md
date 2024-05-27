This example demonstrates the setup and integration of local network gateways with their connections.

## Usage

```hcl
module "vgw" {
  source  = "cloudnationhq/vgw/azure"
  version = "~> 0.3"

  naming = local.naming

  gateway = {
    name          = module.naming.virtual_network_gateway.name
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name

    ip_configurations = {
      config1 = {
        name      = "config1"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
```

```hcl
module "lgw" {
  source  = "cloudnationhq/vgw/azure//modules/local-gateway"
  version = "~> 0.1"

  naming                     = local.naming
  resourcegroup              = module.rg.groups.demo.name
  location                   = module.rg.groups.demo.location
  virtual_network_gateway_id = module.vgw.gateway.id

  local_gateways = local.local_gateways

}
```

The module uses the below locals for configuration:

```hcl
locals {
  local_gateways = {
    adrz = {
      gateway_address = "10.0.0.1"
      address_space   = ["1.2.3.4/32", "4.3.6.7/32"]
      connection = {
        shared_key = "ie9p8y32r78eho'pmkl/dns3289ry"
      }
    }
    haga = {
      gateway_address = "10.0.0.2"
      address_space   = ["1.1.3.4/32", "4.3.2.7/32"]
      connection = {
        shared_key = "ie9p8y32r78eho'pmkl/dns3289ry"
      }
    }
    lzr = {
      gateway_address = "10.0.0.3"
      address_space   = ["1.4.3.4/32", "4.4.2.7/32"]
      connection = {
        shared_key = "ie9p8y32r78eho'pmkl/dns3289ry"
      }
    }
  }
}
```
