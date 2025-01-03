# Active Active

This deploys a active active vpn gateway

## Types

```hcl
gateway = object({
  name           = string
  location       = optional(string)
  resource_group = optional(string)
  active_active  = optional(bool)
  ip_configurations = map(object({
    name      = string
    subnet_id = string
  }))
})
```
