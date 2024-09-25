variable "local_gateways" {
  description = "contains local gateway configuration"
  type        = any
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

variable "resource_group" {
  description = "contains the resourcegroup name"
  type        = string
  default     = null
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
