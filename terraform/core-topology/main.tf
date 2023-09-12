terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "2.9.14"
        }
    }
}

variable "PM_USER" {
    type = string
}

variable "PM_PASSWORD" {
    type = string
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://192.168.100.2:8006/api2/json"
    pm_user = var.PM_USER 
    pm_password = var.PM_PASSWORD
    pm_log_enable = true
    pm_log_file = "terraform-rangebackend.log"
    pm_debug = true
    pm_log_levels = {
        _default = "debug"
        _capturelog = ""
    }

}

resource "proxmox_vm_qemu" "seconion_standalone" {
    count = 1

    name = "seconion-standalone-tf-${count.index}"
    target_node = "r730"
    clone = "SecurityOnion"
    full_clone = true 
    os_type = "linux"
    sockets = 4
    cores = 4
    memory = "32786"
    scsihw = "virtio-scsi-pci"
    oncreate = true

    disk {
        size = "500G"
        type = "scsi"
        storage = "local"
    }

    network {
        model = "e1000"
        bridge = "vmbr7"
    }

}

resource "proxmox_vm_qemu" "domain_controller" {
    count = 1
    name = "win2019-dc-tf-${count.index}"
    target_node = "r730"
    clone = "DomainController"
    full_clone = true
    os_type = "win10"
    sockets = 2
    cores = 4
    memory = "65536"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "100G"
        type = "scsi"
        storage = "local"
    }

    network {
        model = "e1000"
        bridge = "vmbr5"
    }
}

resource "proxmox_vm_qemu" "core_router" {
    name = "core-router-tf"
    target_node = "r730"
    clone = "pfSense"
    full_clone = true

    sockets = 2
    cores = 3
    memory = "8192"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    network {
        model = "virtio"
        bridge = "vmbr1"
    }
    network {
        model = "virtio"
        bridge = "vmbr2"
    }
    network {
        model = "virtio"
        bridge = "vmbr3"
    }
    network {
        model = "virtio"
        bridge = "vmbr4"
    }
    network {
        model = "virtio"
        bridge = "vmbr5"
    }
    network {
        model = "virtio"
        bridge = "vmbr6"
    }
    network {
        model = "virtio"
        bridge = "vmbr7"
    }
    network {
        model = "virtio"
        bridge = "vmbr8"
    }
    network {
        model = "virtio"
        bridge = "vmbr9"
    }
    network {
        model = "virtio"
        bridge = "vmbr10"
    }


}

resource "proxmox_vm_qemu" "dmz_router" {
    name = "dmz-router-tf"
    target_node = "r730"
    clone = "pfSense"
    full_clone = true

    sockets = 2
    cores = 3
    memory = "8192"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    network {
        model = "virtio"
        bridge = "vmbr1"
    }
    network {
        model = "virtio"
        bridge = "vmbr2"
    }
    network {
        model = "virtio"
        bridge = "vmbr3"
    }
    network {
        model = "virtio"
        bridge = "vmbr4"
    }
    network {
        model = "virtio"
        bridge = "vmbr5"
    }
    network {
        model = "virtio"
        bridge = "vmbr6"
    }
    network {
        model = "virtio"
        bridge = "vmbr7"
    }
    network {
        model = "virtio"
        bridge = "vmbr8"
    }
    network {
        model = "virtio"
        bridge = "vmbr9"
    }
    network {
        model = "virtio"
        bridge = "vmbr10"
    }


}

resource "proxmox_vm_qemu" "wan_router" {
    name = "wan-router-tf"
    target_node = "r730"
    clone = "pfSense"
    full_clone = true

    sockets = 2
    cores = 3
    memory = "8192"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    network {
        model = "virtio"
        bridge = "vmbr1"
    }
    network {
        model = "virtio"
        bridge = "vmbr2"
    }
    network {
        model = "virtio"
        bridge = "vmbr3"
    }
    network {
        model = "virtio"
        bridge = "vmbr4"
    }
    network {
        model = "virtio"
        bridge = "vmbr5"
    }
    network {
        model = "virtio"
        bridge = "vmbr6"
    }
    network {
        model = "virtio"
        bridge = "vmbr7"
    }
    network {
        model = "virtio"
        bridge = "vmbr8"
    }
    network {
        model = "virtio"
        bridge = "vmbr9"
    }
    network {
        model = "virtio"
        bridge = "vmbr10"
    }
    

}

