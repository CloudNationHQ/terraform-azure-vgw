This example highlights the complete usage.

## Usage

```hcl
module "vgw" {
  source  = "cloudnationhq/vgw/azure"
  version = "~> 0.1"

  naming = local.naming

  gateway = {
    name          = module.naming.virtual_network_gateway.name
    location      = module.rg.groups.demo.location
    resourcegroup = module.rg.groups.demo.name
    active_active = true

    bgp_settings             = local.bgp_settings
    vpn_client_configuration = local.vpn_client_configuration
    policy_groups            = local.policy_groups

    ip_configurations = {
      config1 = {
        name      = "config1"
        subnet_id = module.network.subnets.sn1.id
      },
      config2 = {
        name      = "config2"
        subnet_id = module.network.subnets.sn1.id
      }
      config3 = {
        name      = "config3"
        subnet_id = module.network.subnets.sn1.id
      }
    }
  }
}
```

The module uses the below locals for configuration:

```hcl
locals {
  bgp_settings = {
    asn = 65512
    peering_addresses = {
      peer1 = {
        ip_configuration_name = "config1"
        apipa_addresses = [
          "169.254.21.0",
          "169.254.22.255"
        ]
      }
      peer2 = {
        ip_configuration_name = "config2"
        apipa_addresses = [
          "169.254.21.0",
          "169.254.22.255"
        ]
      }
    }
  }
  vpn_client_configuration = {
    address_space = ["10.0.1.0/24"]

    root_certificate = {
      cert1 = {
        name = "Verizon-Global-Root-CA"

        public_cert_data = <<EOF
MIIDuzCCAqOgAwIBAgIQCHTZWCM+IlfFIRXIvyKSrjANBgkqhkiG9w0BAQsFADBn
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSYwJAYDVQQDEx1EaWdpQ2VydCBGZWRlcmF0ZWQgSUQg
Um9vdCBDQTAeFw0xMzAxMTUxMjAwMDBaFw0zMzAxMTUxMjAwMDBaMGcxCzAJBgNV
BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
Y2VydC5jb20xJjAkBgNVBAMTHURpZ2lDZXJ0IEZlZGVyYXRlZCBJRCBSb290IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvAEB4pcCqnNNOWE6Ur5j
QPUH+1y1F9KdHTRSza6k5iDlXq1kGS1qAkuKtw9JsiNRrjltmFnzMZRBbX8Tlfl8
zAhBmb6dDduDGED01kBsTkgywYPxXVTKec0WxYEEF0oMn4wSYNl0lt2eJAKHXjNf
GTwiibdP8CUR2ghSM2sUTI8Nt1Omfc4SMHhGhYD64uJMbX98THQ/4LMGuYegou+d
GTiahfHtjn7AboSEknwAMJHCh5RlYZZ6B1O4QbKJ+34Q0eKgnI3X6Vc9u0zf6DH8
Dk+4zQDYRRTqTnVO3VT8jzqDlCRuNtq6YvryOWN74/dq8LQhUnXHvFyrsdMaE1X2
DwIDAQABo2MwYTAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNV
HQ4EFgQUGRdkFnbGt1EWjKwbUne+5OaZvRYwHwYDVR0jBBgwFoAUGRdkFnbGt1EW
jKwbUne+5OaZvRYwDQYJKoZIhvcNAQELBQADggEBAHcqsHkrjpESqfuVTRiptJfP
9JbdtWqRTmOf6uJi2c8YVqI6XlKXsD8C1dUUaaHKLUJzvKiazibVuBwMIT84AyqR
QELn3e0BtgEymEygMU569b01ZPxoFSnNXc7qDZBDef8WfqAV/sxkTi8L9BkmFYfL
uGLOhRJOFprPdoDIUBB+tmCl3oDcBy3vnUeOEioz8zAkprcb3GHwHAK+vHmmfgcn
WsfMLH4JCLa/tRYL+Rw/N3ybCkDp00s0WUZ+AoDywSl0Q/ZEnNY0MsFiw6LyIdbq
M/s/1JRtO3bDSzD9TazRVzn2oBqzSa8VgIo5C1nOnoAKJTlsClJKvIhnRlaLQqk=
EOF

      }
    }

    revoked_certificate = {
      cert1 = {
        name       = "Verizon-Global-Root-CA2"
        thumbprint = "912198EEF23DCAC40939312FEE97DD560BAE49B1"
      }
    }

    ipsec_policy = {
      dh_group                  = "DHGroup14"
      pfs_group                 = "PFS24"
      ike_integrity             = "SHA256"
      ike_encryption            = "AES256"
      ipsec_integrity           = "SHA256"
      ipsec_encryption          = "AES256"
      sa_lifetime_in_seconds    = 3600
      sa_data_size_in_kilobytes = 102400
    }
  }
  policy_groups = {
    group1 = {
      name       = "DefaultAccessPolicyGroup"
      priority   = 1
      is_default = true
      policy_members = {
        member1 = {
          name  = "AdminAADGroup"
          type  = "AADGroupId"
          value = "12345678-1234-1234-1234-123456789abc"
        }
      }
    },
    group2 = {
      name       = "GuestAccessPolicyGroup"
      priority   = 10
      is_default = false
      policy_members = {
        member1 = {
          name  = "GuestRadiusGroup"
          type  = "RadiusAzureGroupId"
          value = "34567-cdefg-89012-hijkl-34567"
        }
      }
    }
  }
}
```

```hcl
module "lgw" {
  source  = "cloudnationhq/vgw/azure//modules/local-gateway"
  version = "~> 0.1"

  naming        = local.naming
  resourcegroup = module.rg.groups.demo.name
  location      = module.rg.groups.demo.location

  virtual_network_gateway_id = module.vgw.gateway.id

  local_gateways = {
    adrz = {
      gateway_address = "10.0.0.1"
      address_space   = ["1.2.3.4/32", "4.3.6.7/32"]
      connection = {
        shared_key = "aZ4!bG8@fH2#nQ6^wS1*"
      }
    }
  }
}
```
