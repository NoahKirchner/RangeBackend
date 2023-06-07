source "proxmox-iso" "test-me" {
    disks {
        disk_size = "10G"
        storage_pool = "local"
        type = "scsi"
    }
    iso_file = "local:iso/ubuntudesktopraw.iso"
    node = "r730"
    proxmox_url = "https://192.168.100.2:8006/api2/json"
    ssh_password = "1qaz2wsx!QAZ@WSX"
    ssh_timeout = "15m"
    ssh_username = "defender"
    template_description = "huh"
    template_name = "test-me"
}

build {
    sources = ["source.proxmox-iso.test-me"]
}
