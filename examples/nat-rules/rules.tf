locals {
  rules = {
    rule1 = {
      mode                = "EgressSnat"
      type                = "Dynamic"
      ip_configuration_id = module.vgw.ip_configuration_ids.default.name

      external_mappings = {
        address_space = "203.0.113.0/27"
      }
      internal_mappings = {
        address_space = "101.18.1.0/27"
      }
    }
    rule2 = {
      mode                = "EgressSnat"
      type                = "Dynamic"
      ip_configuration_id = module.vgw.ip_configuration_ids.default.name

      external_mappings = {
        address_space = "102.0.113.0/27"
      }
      internal_mappings = {
        address_space = "104.0.1.0/27"
      }
    }
  }
}
