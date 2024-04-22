module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "prd"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 0.1"

  groups = {
    demo = {
      name   = module.naming.resource_group.name
      region = "northeurope"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 2.0"

  naming = local.naming

  vnet = {
    name          = module.naming.virtual_network.name
    cidr          = ["10.18.0.0/16"]
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        name = "gatewaysubnet"
        cidr = ["10.18.1.0/24"]
      }
    }
  }
}

module "lgw" {
  source = "../../modules/local-gateway/"

  naming        = local.naming
  resourcegroup = module.rg.groups.demo.name
  location      = module.rg.groups.demo.location

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
  source = "../.."

  naming = local.naming

  gateway = {
    name          = module.naming.virtual_network_gateway.name
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name
    active_active = true

    bgp_settings             = local.bgp_settings
    vpn_client_configuration = local.vpn_client_configuration
    policy_groups            = local.policy_groups

    ip_configurations = {
      config1 = {
        name      = "config1"
        subnet_id = module.network.subnets.sn1.id
      },
      config2 = {
        name      = "config2"
        subnet_id = module.network.subnets.sn1.id
      }
      config3 = {
        name      = "config3"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
