variable "rules" {
  description = "Contains all nat rules"
  type = map(object({
    name                       = optional(string, null)
    mode                       = string
    type                       = string
    virtual_network_gateway_id = optional(string, null)
    ip_configuration_id        = optional(string, null)
    external_mappings = object({
      address_space = string
      port_range    = optional(string, null)
    })
    internal_mappings = object({
      address_space = string
      port_range    = optional(string, null)
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
