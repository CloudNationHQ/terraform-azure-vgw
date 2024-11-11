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
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
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
        name = "GatewaySubnet"
        cidr = ["10.18.1.0/24"]
      }
    }
  }
}

module "lgw" {
  source  = "cloudnationhq/vgw/azure//modules/local-gateway"
  version = "~> 1.0"

  naming                     = local.naming
  resource_group             = module.rg.groups.demo.name
  location                   = module.rg.groups.demo.location
  virtual_network_gateway_id = module.vgw.gateway.id

  local_gateways = local.local_gateways

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
      config1 = {
        name      = "config1"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
