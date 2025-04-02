# =============================================================================
# ===== Example - Basic Clone =================================================
# =============================================================================

# Minimum configuration required for successful clone of a Proxmox template.

module "pve_vm" {
  source = "../.."

  ct_type  = "template"
  pve_node = var.proxmox_node

  src_file         = {
    datastore_id  = "image"
    file_name     = "debian-12-standard_12.7-1_amd64.tar.zst"
  }

  ct_name = "example-basic-templatec"
  ct_template = true

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
