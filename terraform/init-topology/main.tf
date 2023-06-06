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

resource "proxmox_vm_qemu" "blank_pfsense" {
    name = "blank-pfsense"
    target_node = "r730"
    iso = "local:iso/pfsenseraw.iso"
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

resource "proxmox_vm_qemu" "blank_win10" {
    name = "blank-win10"
    target_node = "r730"
    iso = "local:iso/win10raw.iso"
    sockets = 2
    cores = 2
    memory = "4096"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }
}

resource "proxmox_vm_qemu" "blank_kali" {
    name = "blank-kali"
    target_node = "r730"
    iso = "local:iso/kaliraw.iso"
    sockets = 2
    cores = 4
    memory = "8192"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }
}

resource "proxmox_vm_qemu" "blank_ubuntu_desktop" {
    name = "blank-ubuntu-desktop"
    target_node = "r730"
    iso = "local:iso/ubuntudesktopraw.iso"
    sockets = 2
    cores = 2
    memory = "8192"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }
}

resource "proxmox_vm_qemu" "blank_win2019_server" {
    name = "blank-win2019-server"
    target_node = "r730"
    iso = "local:iso/winserverraw.iso"
    sockets = 2
    cores = 4
    memory = "8192"
    scsihw = "virtio-scsi-pci"
    oncreate = true 

    disk {
        size = "50G"
        type = "scsi"
        storage = "local"
    }
}

resource "proxmox_vm_qemu" "blank_seconion_standalone" {
    name = "blank-seconion-standalone"
    target_node = "r730"
    iso = "local:iso/seconionraw.iso"
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

}
