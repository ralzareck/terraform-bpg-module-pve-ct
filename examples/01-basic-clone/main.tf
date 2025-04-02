# =============================================================================
# ===== Example - Basic Clone =================================================
# =============================================================================

# Minimum configuration required for successful clone of a Proxmox template.

module "pve_vm" {
  source = "../.."

  ct_type  = "clone"
  pve_node = var.proxmox_node

  src_clone = {
    datastore_id = "data"
    tpl_id       = 1000
  }

  ct_name = "example-basic-clone"

  ct_disk = {
    datastore_id = "data"
    size         = 8
  }

  ct_net_ifaces = {
    net0 = {
      name      = "eth0"
      bridge    = "vmbr0"
      ipv4_addr = "10.0.0.1/24"
      ipv4_gw   = "10.0.0.1"
    }
  }
}
