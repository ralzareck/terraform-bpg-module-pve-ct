<!-- markdownlint-disable MD033 -->
# terraform-bpg-proxmox-lxc

Based on [bpg's provider](https://github.com/bpg/terraform-provider-proxmox)

## Create a LXC CT on ProxmoxVE using Terraform

This module deploys a LXC Container on ProxmoxVE host, with firewall configuration.
It can be based on an already deployed CT template, or an existing LXC template.

![GitHub License](https://img.shields.io/github/license/ralzareck/terraform-module-bgp-pve-ct?style=flat&color=blue)

## Providers

Here is the list of required providers:

| Name                                                                         | Version   |
| ---------------------------------------------------------------------------- | --------- |
| [bgp/proxmox](https://registry.terraform.io/providers/bpg/proxmox)           | >= 0.66.0 |
| [hashicorp/random](https://registry.terraform.io/providers/hashicorp/random) | ~> 3.0.0  |
| [hashicorp/time](https://registry.terraform.io/providers/hashicorp/time)     | ~> 0.0    |

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_container.pve_ct](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_container) | resource |
| [proxmox_virtual_environment_firewall_options.pve_ct_fw_opts](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_firewall_options) | resource |
| [proxmox_virtual_environment_firewall_rules.pve_ct_fw_rules](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_firewall_rules) | resource |
| [random_password.ct_root_pw](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [terraform_data.bootstrap_ct](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [time_sleep.wait_for_ct](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

Here are the input variables of the module:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pve_node"></a> [pve\_node](#input\_pve\_node) | PVE Node name on which the VM will be created on. | `string` | `n/a` | $\color{green}{yes}$ |
| <a name="input_ct_type"></a> [ct\_type](#input\_ct\_type) | The source type used for the creation of the container. Can either be 'clone' or 'template'. | `string` | `n/a` | $\color{green}{yes}$ |
| <a name="input_ct_template"></a> [ct\_template](#input\_ct\_template) | Defines if the container should be converted to a template or not. | `bool` | `false` | $\color{red}{no}$ |
| <a name="input_src_clone"></a> [src\_clone](#input\_src\_clone) | The target Container to clone. Can not be used with 'src\_file' | <pre>object({<br/>    datastore\_id = string<br/>    node\_name    = optional(string)<br/>    tpl\_id       = number<br/>  })</pre> | `null` | $\color{red}{no}$ |
| <a name="input_src_file"></a> [src\_file](#input\_src\_file) | The target template file to use as base for the Container. Cannot be used with 'src\_clone' | <pre>object({<br/>    datastore\_id = string<br/>    file\_name    = string<br/>  })</pre> | `null` | $\color{red}{no}$ |
| <a name="input_ct_name"></a> [ct\_name](#input\_ct\_name) | The name of the Container. | `string` | `n/a` | $\color{green}{yes}$ |
| <a name="input_ct_id"></a> [ct\_id](#input\_ct\_id) | The ID of the Container. | `number` | `null` | $\color{red}{no}$ |
| <a name="input_ct_description"></a> [ct\_description](#input\_ct\_description) | The description of the Container. | `string` | `null` | $\color{red}{no}$ |
| <a name="input_ct_unprivileged"></a> [ct\_unprivileged](#input\_ct\_unprivileged) | Defines if the container runs as unprivileged on the host. | `bool` | `true` | $\color{red}{no}$ |
| <a name="input_ct_protection"></a> [ct\_protection](#input\_ct\_protection) | Defines if protection is enabled on the container. | `bool` | `false` | $\color{red}{no}$ |
| <a name="input_ct_pool"></a> [ct\_pool](#input\_ct\_pool) | The Pool in which to place the Container. | `string` | `null` | $\color{red}{no}$ |
| <a name="input_ct_tags"></a> [ct\_tags](#input\_ct\_tags) | A list of tags associated to the Container. | `list(string)` | `[]` | $\color{red}{no}$ |
| <a name="input_ct_start"></a> [ct\_start](#input\_ct\_start) | Defines startup and shutdown behavior of the container. | <pre>object({<br/>    on\_deploy  = bool<br/>    on\_boot    = bool<br/>    order      = optional(number, 0)<br/>    up\_delay   = optional(number, 0)<br/>    down\_delay = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "down\_delay": 0,<br/>  "on\_boot": false,<br/>  "on\_deploy": true,<br/>  "order": 0,<br/>  "up\_delay": 0<br/>}</pre> | $\color{red}{no}$ |
| <a name="input_ct_os"></a> [ct\_os](#input\_ct\_os) | The Operating System configuration of the container. | `string` | `"unmanaged"` | $\color{red}{no}$ |
| <a name="input_ct_cpu"></a> [ct\_cpu](#input\_ct\_cpu) | The CPU Configuration of the container. | <pre>object({<br/>    arch  = optional(string)<br/>    cores = optional(number, 2)<br/>    units = optional(number)<br/>  })</pre> | `{}` | $\color{red}{no}$ |
| <a name="input_ct_mem"></a> [ct\_mem](#input\_ct\_mem) | The Memory Configuration of the container. | <pre>object({<br/>    dedicated = optional(number, 2048)<br/>    swap      = optional(number)<br/>  })</pre> | `{}` | $\color{red}{no}$ |
| <a name="input_ct_console"></a> [ct\_console](#input\_ct\_console) | The Console Configuration of the container. | <pre>object({<br/>    enabled   = optional(bool, true)<br/>    type      = optional(string, "shell")<br/>    tty\_count = optional(number, 2)<br/>  })</pre> | `{}` | $\color{red}{no}$ |
| <a name="input_ct_features"></a> [ct\_features](#input\_ct\_features) | The container feature flags. Changing flags (except nesting) is only allowed for root@pam authenticated user. | <pre>object({<br/>    nesting = optional(bool, false)<br/>    fuse    = optional(bool)<br/>    keyctl  = optional(bool)<br/>    mount   = optional(list(string))<br/>  })</pre> | `{}` | $\color{red}{no}$ |
| <a name="input_ct_disk"></a> [ct\_disk](#input\_ct\_disk) | The Disks configuration of the container. | <pre>object({<br/>    datastore\_id = string<br/>    size         = number<br/>  })</pre> | `n/a` | $\color{green}{yes}$ |
| <a name="input_ct_net_ifaces"></a> [ct\_net\_ifaces](#input\_ct\_net\_ifaces) | The network interfaces configuration of the container. | <pre>map(object({<br/>    name       = string<br/>    bridge     = string<br/>    enabled    = optional(bool, true)<br/>    firewall   = optional(bool, true)<br/>    mac\_addr   = optional(string)<br/>    model      = optional(string, "virtio")<br/>    mtu        = optional(number, 1500)<br/>    rate\_limit = optional(string)<br/>    vlan\_id    = optional(number)<br/>    ipv4\_addr  = string<br/>    ipv4\_gw    = string<br/>  }))</pre> | `{}` | $\color{red}{no}$ |
| <a name="input_ct_init"></a> [ct\_init](#input\_ct\_init) | The initialization configuration of the container. | <pre>object({<br/>    user = optional(object({<br/>      password = optional(string)<br/>      keys     = optional(list(string))<br/>    }))<br/>    dns = optional(object({<br/>      domain  = optional(string)<br/>      servers = optional(list(string))<br/>    }))<br/>  })</pre> | `{}` | $\color{red}{no}$ |
| <a name="input_ct_fw_opts"></a> [ct\_fw\_opts](#input\_ct\_fw\_opts) | Firewall settings of the container. | <pre>object({<br/>    enabled       = bool<br/>    dhcp          = optional(bool)<br/>    input\_policy  = optional(string)<br/>    output\_policy = optional(string)<br/>    macfilter     = optional(bool)<br/>    ipfilter      = optional(bool)<br/>    ndp           = optional(bool)<br/>    radv          = optional(bool)<br/>  })</pre> | `null` | $\color{red}{no}$ |
| <a name="input_ct_fw_rules"></a> [ct\_fw\_rules](#input\_ct\_fw\_rules) | Firewall rules of the container. | <pre>map(object({<br/>    enabled   = optional(bool, true)<br/>    action    = string<br/>    direction = string<br/>    iface     = optional(string)<br/>    proto     = optional(string)<br/>    srcip     = optional(string)<br/>    srcport   = optional(string)<br/>    destip    = optional(string)<br/>    destport  = optional(string)<br/>    comment   = optional(string)<br/>  }))</pre> | `null` | $\color{red}{no}$ |
| <a name="input_ct_fw_group"></a> [ct\_fw\_group](#input\_ct\_fw\_group) | Firewall Security Groups of the container. | <pre>map(object({<br/>    enabled = optional(bool, true)<br/>    iface   = optional(string)<br/>    comment = optional(string)<br/>  }))</pre> | `null` | $\color{red}{no}$ |
| <a name="input_ct_ssh_privkey"></a> [ct\_ssh\_privkey](#input\_ct\_ssh\_privkey) | File containing ssh private key to be used for container bootstrap. | `string` | `null` | $\color{red}{no}$ |
| <a name="input_ct_bootstrap"></a> [ct\_bootstrap](#input\_ct\_bootstrap) | List of paths to script files to be executed after container creation. Scripts will be executed in the order provided. | <pre>map(object({<br/>    script\_path = optional(string)<br/>    arguments   = optional(string)<br/>  }))</pre> | `{}` | $\color{red}{no}$ |
<!-- END_TF_DOCS -->
