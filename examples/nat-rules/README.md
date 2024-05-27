This example showcases the configuration of NAT rules.

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
      default = {
        name      = "vnetgatewayconfig"
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

  naming        = local.naming
  resourcegroup = module.rg.groups.demo.name
  location      = module.rg.groups.demo.location

  virtual_network_gateway_id = module.vgw.gateway.id

  local_gateways = {
    adrz = {
      gateway_address = "10.0.0.1"
      address_space   = ["1.2.3.4/32"]
      connection = {
        shared_key = "ie9p8y32r78eho'pmkl/dns3289ry"
        egress_nat_rule_ids = [
          module.nat.rules.rule1.id,
          module.nat.rules.rule2.id
        ]
      }
    }
  }
}
```

```hcl
module "nat" {
  source  = "cloudnationhq/vgw/azure//modules/nat-rules"
  version = "~> 0.1"

  naming        = local.naming
  resourcegroup = module.rg.groups.demo.name
  rules         = local.rules

  virtual_network_gateway_id = module.vgw.gateway.id
}
```

The module uses the below locals for configuration:

```hcl
locals {
  rules = {
    rule1 = {
      mode                = "EgressSnat"
      type                = "Dynamic"
      ip_configuration_id = module.vgw.ip_configuration_ids.default.name

      external_mappings = {
        address_space = "203.0.113.0/27"
      }
      internal_mappings = {
        address_space = "101.18.1.0/27"
      }
    }
    rule2 = {
      mode                = "EgressSnat"
      type                = "Dynamic"
      ip_configuration_id = module.vgw.ip_configuration_ids.default.name

      external_mappings = {
        address_space = "102.0.113.0/27"
      }
      internal_mappings = {
        address_space = "104.0.1.0/27"
      }
    }
  }
}
```
