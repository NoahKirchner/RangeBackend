source "proxmox-iso" "win10" {
    memory = "4096"
    sockets = 1
    cores = 2
    cpu_type = "host"
    os = "win10"
    network_adapters {
        model = "e1000"
        bridge = "vmbr0"
    }
    disks {
        disk_size = "50G"
        storage_pool = "local"
        type = "scsi"
    }
    insecure_skip_tls_verify = true
    iso_file = "local:iso/Windows10.iso"
    node = "r730"
    proxmox_url = "https://192.168.100.2:8006/api2/json"
    communicator = "winrm"
    winrm_password = "whitecell"
    winrm_timeout = "15m"
    winrm_username = "Administrator"
    template_description = "Windows 10"
    template_name = "win10-template"
    additional_iso_files {
        iso_storage_pool = "local"
        cd_files = ["preseeds/10/autounattend.xml"]
        cd_label = "windata"
    }
    boot_wait = "10s"
}

build {
    sources = ["source.proxmox-iso.win10"]
}
