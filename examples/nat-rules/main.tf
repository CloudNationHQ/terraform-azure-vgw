module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 8.0"

  naming = local.naming

  vnet = {
    name           = module.naming.virtual_network.name
    address_space  = ["10.18.0.0/16"]
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        name             = "gatewaysubnet"
        address_prefixes = ["10.18.1.0/24"]
      }
    }
  }
}

module "nat" {
  source  = "cloudnationhq/vgw/azure//modules/nat-rules"
  version = "~> 2.0"

  naming              = local.naming
  resource_group_name = module.rg.groups.demo.name
  rules               = local.rules

  virtual_network_gateway_id = module.vgw.gateway.id
}

module "lgw" {
  source  = "cloudnationhq/vgw/azure//modules/local-gateway"
  version = "~> 2.0"

  naming              = local.naming
  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

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

module "vgw" {
  source  = "cloudnationhq/vgw/azure"
  version = "~> 2.0"

  naming = local.naming

  gateway = {
    name                = module.naming.virtual_network_gateway.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    ip_configurations = {
      default = {
        name      = "vnetgatewayconfig"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
