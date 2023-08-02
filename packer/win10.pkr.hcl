source "proxmox-iso" "win10" {
    memory = "8192"
    sockets = 2
    cores = 4
    cpu_type = "host"
    os = "win10"
    network_adapters {
        model = "e1000"
        bridge = "vmbr0"
    }
    disks {
        disk_size = "50G"
        storage_pool = "local"
        type = "ide"
        format = "qcow2"
    }
    insecure_skip_tls_verify = true
    iso_file = "local:iso/win10raw.iso"
    node = "r730"
    proxmox_url = "https://192.168.100.2:8006/api2/json"
    communicator = "ssh"
    ssh_host = "192.168.100.210"
    ssh_password = "whitecell"
    ssh_timeout = "60m"
    ssh_username = "whitecell"
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
