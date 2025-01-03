# Complete

This deploys the complete vpn gateway

## Types

```hcl
gateway = object({
  name           = string
  location       = optional(string)
  resource_group = optional(string)
  active_active  = optional(bool)

  bgp_settings = optional(object({
    asn = number
    peering_addresses = map(object({
      ip_configuration_name = string
      apipa_addresses      = list(string)
    }))
  }))

  vpn_client_configuration = optional(object({
    address_space = list(string)
    root_certificate = optional(map(object({
      name             = string
      public_cert_data = string
    })))
    revoked_certificate = optional(map(object({
      name       = string
      thumbprint = string
    })))
    ipsec_policy = optional(object({
      dh_group                   = string
      pfs_group                  = string
      ike_integrity              = string
      ike_encryption            = string
      ipsec_integrity           = string
      ipsec_encryption          = string
      sa_lifetime_in_seconds     = number
      sa_data_size_in_kilobytes = number
    }))
  }))

  policy_groups = optional(map(object({
    name       = string
    priority   = number
    is_default = optional(bool)
    policy_members = optional(map(object({
      name  = string
      type  = string
      value = string
    })))
  })))

  ip_configurations = map(object({
    name      = string
    subnet_id = string
  }))
})
```

## Notes

The following shows the local gateway type definition, which is a submodule

```hcl
resource_group = string
location = string
virtual_network_gateway_id = string

local_gateways = map(object({
  gateway_address = optional(string)
  address_space  = optional(list(string))
  connection = object({
    shared_key = string
  })
}))
```
