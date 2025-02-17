<!-- markdownlint-disable MD033 -->
# terraform-module-pve-ct

Based on [bpg's provider](https://github.com/bpg/terraform-provider-proxmox)

## Create a LXC CT on ProxmoxVE using Terraform

This module deploys a LXC Container on ProxmoxVE host, with firewall configuration.
It can be based on an already deployed CT template, or an existing LXC template.

![GitHub License](https://img.shields.io/github/license/ralzareck/terraform-module-bgp-pve-ct?style=flat&color=blue)

## Providers

Here is the list of required providers:

| Name                                                                             | Version   |
| -------------------------------------------------------------------------------- | --------- |
| [bgp/proxmox](https://search.opentofu.org/provider/bpg/proxmox/v0.66.0)          | >= 0.66.0 |
| [hashicorp/random](https://search.opentofu.org/provider/hashicorp/random/latest) | ~> 3.0.0  |
| [hashicorp/time](https://search.opentofu.org/provider/hashicorp/time/latest)     | ~> 0.0    |

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
