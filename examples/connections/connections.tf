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
  }
}
