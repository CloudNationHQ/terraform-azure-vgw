# Nat Rules

This deploys vpn gateway nat rules

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

The following shows the local gateway and nat rules type definitions, which are submodules

```hcl
resource_group             = string
location                   = string
virtual_network_gateway_id = string

local_gateways = map(object({
  gateway_address = optional(string)
  address_space   = optional(list(string))
  connection = object({
    shared_key          = string
    egress_nat_rule_ids = optional(list(string))
  })
}))
```

```hcl
resource_group             = string
virtual_network_gateway_id = string

rules = map(object({
  name                       = optional(string)
  mode                       = string
  type                       = string
  ip_configuration_id        = optional(string)
  virtual_network_gateway_id = optional(string)
  external_mappings = object({
    address_space = string
    port_range    = optional(string)
  })
  internal_mappings = object({
    address_space = string
    port_range    = optional(string)
  })
}))
```
