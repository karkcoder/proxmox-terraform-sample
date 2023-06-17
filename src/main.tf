terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.api_url
  pm_api_token_id     = var.token_id
  pm_api_token_secret = var.token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "test_server" {
  define_connection_info = false
  agent                  = 1
  count                  = 1                            # just want 1 for now, set to 0 and apply to destroy VM
  name                   = "test-vm-${count.index + 1}" #count.index starts at 0, so + 1 means this VM will be named test-vm-1 in proxmox
  target_node            = var.proxmox_host
  iso                    = "local:iso/ubuntu-22.04.1-live-server-amd64.iso"

  # basic VM settings here. agent refers to guest agent
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 2048
  os_type = "ubuntu"

  disk {
    size    = "10G"
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = var.nic_name
  }

  lifecycle {
    ignore_changes = [
      network,
      vmid
    ]
  }
}
