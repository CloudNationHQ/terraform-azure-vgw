variable "rules" {
  description = "Contains all nat rules"
  type = map(object({
    name                       = optional(string)
    mode                       = string
    type                       = string
    virtual_network_gateway_id = optional(string)
    ip_configuration_id        = optional(string)
    external_mappings = object({
      address_space = string
      port_range    = optional(string)
    })
    internal_mappings = object({
      address_space = string
      port_range    = optional(string)
    })
  }))
}

variable "virtual_network_gateway_id" {
  description = "contains virtual network gateway id"
  type        = string
  default     = null
}

variable "location" {
  description = "contains the region"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "contains the resourcegroup name"
  type        = string
  default     = null
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = null
}
