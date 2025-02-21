# Changelog

## [1.4.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v1.3.0...v1.4.0) (2025-02-21)


### Features

* add edge zone support and default policy group flag ([#56](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/56)) ([8146e01](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/8146e01958859729fc10cc35e3ffbb1c40d609c4))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#55](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/55)) ([2d080fe](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/2d080fedda81b873111beebe5116e2c2e0c940e1))

## [1.3.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v1.2.1...v1.3.0) (2025-01-06)


### Features

* add support for custom bgp addresses, traffic seclector policies, and bgp settings in local network gateways and connections ([#52](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/52)) ([da422cc](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/da422cccdff3da3bd51cefb19e01d496147102c3))
* add support for domain name label scope public ip's ([#46](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/46)) ([eb4abaa](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/eb4abaa1bda6caf05c80b537cdbbb7bcf9e47271))
* add type definitions all usages and incremented all module versions to the latest ([#50](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/50)) ([675ff21](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/675ff211a4079b97cd08461f4b502f88d73b7a5b))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#45](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/45)) ([f8e5dfb](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/f8e5dfbcf8a7ca55046ba3dcb5ab405d146ae1f6))
* **deps:** bump golang.org/x/crypto from 0.29.0 to 0.31.0 in /tests ([#48](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/48)) ([c599277](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/c599277b6e0821ac449ad5e6f8871bc54141b2ec))
* improve destroy functionality in tests ([#49](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/49)) ([7909511](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/790951105deb6c5247d9300f478d1c782bf07dec))

## [1.2.1](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v1.2.0...v1.2.1) (2024-11-13)


### Bug Fixes

* fix submodule documentation generation ([#42](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/42)) ([450ec62](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/450ec6250336fce2e3c4f004ac93536e0ae135a3))

## [1.2.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v1.1.0...v1.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#40](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/40)) ([2b213a4](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/2b213a41065c2c57ea2d49a105d633d368dc107c))

## [1.1.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v1.0.0...v1.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#38](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/38)) ([c83cab8](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/c83cab87b2e8117957bd5130b4ed445c52fa1e81))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#37](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/37)) ([16b091a](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/16b091aceac7e22c66f3c8f5f4cee387b22febf2))

## [1.0.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.9.0...v1.0.0) (2024-09-25)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#35](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/35)) ([893aa76](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/893aa76d917aaa8c0dcfc5359c4516abc892ae7a))

### Upgrade from v0.9.0 to v1.0.0:

- Update module reference to: `version = "~> 1.0"`
- Change properties in gateway object:
  - resourcegroup -> resource_group
- Rename variable:
  - resourcegroup -> resource_group

## [0.9.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.8.0...v0.9.0) (2024-08-28)


### Features

* update documentation ([#32](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/32)) ([26c46bb](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/26c46bbf02674541ec4f228cdfc355e94617d712))

## [0.8.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.7.0...v0.8.0) (2024-08-28)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#31](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/31)) ([b915d7d](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/b915d7d9f5442fa6bcd06f4a185f52f79b2b1238))
* update contribution docs ([#29](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/29)) ([8bb34aa](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/8bb34aaf24c55dc342dad088939f93d7fbe19339))

## [0.7.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.6.1...v0.7.0) (2024-07-02)


### Features

* add issue template ([#26](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/26)) ([68d280b](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/68d280b46385ab9d8412120611b749837991c79d))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#27](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/27)) ([f76b2d8](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/f76b2d80b63b6dbcb4511528a94a755a6b10094f))

## [0.6.1](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.6.0...v0.6.1) (2024-06-21)


### Bug Fixes

* fixed conditionally include ip_configuration_id for dynamic nat rules only ([#24](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/24)) ([35add3b](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/35add3b05eac4b4bd16fbe8fb4e6b3aa6a4694c8))

## [0.6.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.5.0...v0.6.0) (2024-06-14)


### Features

* changed default value dpd timeout seconds on network gateway connections ([#20](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/20)) ([3509ce8](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/3509ce8ec0deb429bd0b2014728efcc247047515))

## [0.5.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.4.0...v0.5.0) (2024-06-07)


### Features

* add pull request template ([d9319b6](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/d9319b6fdbdd432101e25e64c61cfdbf67c28d22))

## [0.4.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.3.0...v0.4.0) (2024-06-04)


### Features

* add ipsec policy support on virtual network gateway connections ([#13](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/13)) ([c7d2c5d](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/c7d2c5d09f0fc94057c49c9cdab5029585da05c8))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#11](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/11)) ([8d975bf](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/8d975bfb12d6430d7699ce6b1ff2528905798043))

## [0.3.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.2.0...v0.3.0) (2024-05-27)


### Features

* add support for tags all submodules ([#9](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/9)) ([abdba79](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/abdba799b27ae7b63d4fa330178e4a5e16234710))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#8](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/8)) ([d38903b](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/d38903b9e6d001614711f10d0117dfc7a8b47407))
* **deps:** bump github.com/hashicorp/go-getter in /tests ([#7](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/7)) ([025f424](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/025f424b687d82bb01076ff5f7bc68d4ecd534c4))

## [0.2.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.1.0...v0.2.0) (2024-04-22)


### Features

* small update documentation ([#5](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/5)) ([e933e5e](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/e933e5ef4d815c342f19b5cd7419fad4265118f9))

## 0.1.0 (2024-04-22)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/2)) ([f17bc2c](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/f17bc2c144e914381660eff8ff323cea8dc6d890))
* **deps:** bump golang.org/x/net from 0.17.0 to 0.23.0 in /tests ([#4](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/4)) ([b328305](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/b328305ea0e8669ba54e6154ddaeb48d10f15924))
