locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = ["subnet", "network_security_group", "public_ip", "local_network_gateway", "virtual_network_gateway_connection"]
}

locals {
  local_gateways = {
    adrz = {
      gateway_address = "10.0.0.1"
      address_space   = ["1.2.3.4/32", "4.3.6.7/32"]
      connection = {
        shared_key = "ie9p8y32r78eho'pmkl/dns3289ry"
        ipsec_policy = {
          dh_group         = "DHGroup2"
          ike_encryption   = "AES256"
          ike_integrity    = "SHA256"
          ipsec_encryption = "AES256"
          ipsec_integrity  = "SHA256"
          pfs_group        = "PFS2"
        }
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
