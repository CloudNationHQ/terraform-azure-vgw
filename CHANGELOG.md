# Changelog

## [1.0.0](https://github.com/CloudNationHQ/terraform-azure-vgw/compare/v0.9.0...v1.0.0) (2024-09-25)


### ⚠ BREAKING CHANGES

* * Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#35](https://github.com/CloudNationHQ/terraform-azure-vgw/issues/35)) ([893aa76](https://github.com/CloudNationHQ/terraform-azure-vgw/commit/893aa76d917aaa8c0dcfc5359c4516abc892ae7a))

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
