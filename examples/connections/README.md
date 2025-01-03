# Connections

This deploys vpn gateway connections

## Types

```hcl
gateway = object({
 name           = string
 location       = optional(string)
 resource_group = optional(string)
 ip_configurations = map(object({
   name      = string
   subnet_id = string
 }))
})
```

The following shows the local gateway type definition, which is a submodule

```hcl
resource_group             = string
location                   = string
virtual_network_gateway_id = string

local_gateways = map(object({
  gateway_address = optional(string)
  address_space   = optional(list(string))
  connection = object({
    shared_key = string
    ipsec_policy = optional(object({
      dh_group         = string
      ike_encryption   = string
      ike_integrity    = string
      ipsec_encryption = string
      ipsec_integrity  = string
      pfs_group        = string
    }))
  })
}))
```
