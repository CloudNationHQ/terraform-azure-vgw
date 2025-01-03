# Active Passive

This deploys a active passive vpn gateway

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
