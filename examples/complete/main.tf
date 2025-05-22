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
      address_space   = ["1.2.3.4/32", "4.3.6.7/32"]
      connection = {
        shared_key = "aZ4!bG8@fH2#nQ6^wS1*"
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
    active_active       = true

    bgp_settings             = local.bgp_settings
    vpn_client_configuration = local.vpn_client_configuration
    policy_groups            = local.policy_groups

    ip_configurations = {
      config1 = {
        subnet_id = module.network.subnets.sn1.id
      },
      config2 = {
        subnet_id = module.network.subnets.sn1.id
      }
      config3 = {
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
