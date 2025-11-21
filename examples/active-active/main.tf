module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.25"

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
  version = "~> 9.0"

  naming = local.naming

  vnet = {
    name                = module.naming.virtual_network.name
    address_space       = ["10.18.0.0/16"]
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    subnets = {
      sn1 = {
        name             = "GatewaySubnet"
        address_prefixes = ["10.18.1.0/24"]
      }
    }
  }
}

module "public_ip" {
  source  = "cloudnationhq/pip/azure"
  version = "~> 4.0"

  naming = local.naming

  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

  configs = {
    pip1 = {
      name              = "${module.naming.public_ip.name}-vgw-01"
      allocation_method = "Static"
      sku               = "Standard"
      zones             = ["1", "2", "3"]
    }
    pip2 = {
      name              = "${module.naming.public_ip.name}-vgw-02"
      allocation_method = "Static"
      sku               = "Standard"
      zones             = ["1", "2", "3"]
    }
  }
}

module "vgw" {
  source  = "cloudnationhq/vgw/azure"
  version = "~> 3.0"

  naming = local.naming

  gateway = {
    name                = module.naming.virtual_network_gateway.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    active_active       = true

    ip_configurations = {
      config1 = {
        name                 = "config1"
        subnet_id            = module.network.subnets.sn1.id
        public_ip_address_id = module.public_ip.configs.pip1.id
      },
      config2 = {
        name                 = "config2"
        subnet_id            = module.network.subnets.sn1.id
        public_ip_address_id = module.public_ip.configs.pip2.id
      }
    }
  }
}
