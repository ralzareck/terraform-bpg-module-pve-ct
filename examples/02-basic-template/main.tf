# Copyright 2025 RalZareck
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# =============================================================================
# ===== Example - Basic Clone =================================================
# =============================================================================

# Minimum configuration required for successful clone of a Proxmox template.

module "pve_vm" {
  source = "../.."

  ct_type  = "template"
  pve_node = var.proxmox_node

  src_file = {
    datastore_id = "image"
    file_name    = "debian-12-standard_12.7-1_amd64.tar.zst"
  }

  ct_name     = "example-basic-templatec"
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
