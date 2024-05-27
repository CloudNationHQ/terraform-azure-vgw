This example showcases the setup of an active passive configuration.

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
