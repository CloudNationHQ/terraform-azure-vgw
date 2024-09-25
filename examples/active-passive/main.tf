module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "northeurope"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 4.0"

  naming = local.naming

  vnet = {
    name           = module.naming.virtual_network.name
    cidr           = ["10.18.0.0/16"]
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        name = "gatewaysubnet"
        cidr = ["10.18.1.0/24"]
      }
    }
  }
}

module "vgw" {
  source  = "cloudnationhq/vgw/azure"
  version = "~> 1.0"

  naming = local.naming

  gateway = {
    name           = module.naming.virtual_network_gateway.name
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    ip_configurations = {
      default = {
        name      = "vnetgatewayconfig"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
