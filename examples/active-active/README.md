This example showcases the setup of an active active configuration.

## Usage

```hcl
module "vgw" {
  source  = "cloudnationhq/vgw/azure"
  version = "~> 0.2"

  naming = local.naming

  gateway = {
    name          = module.naming.virtual_network_gateway.name
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name
    active_active = true

    ip_configurations = {
      config1 = {
        name      = "config1"
        subnet_id = module.network.subnets.sn1.id
      },
      config2 = {
        name      = "config2"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
```
