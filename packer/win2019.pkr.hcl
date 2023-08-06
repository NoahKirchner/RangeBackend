source "proxmox-iso" "win2019" {
    memory = "8192"
    sockets = 2
    cores = 4
    cpu_type = "host"
    os = "other"
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
    iso_file = "local:iso/winserverraw.iso"
    node = "r730"
    proxmox_url = "https://192.168.100.2:8006/api2/json"
    communicator = "ssh"
    ssh_host = "192.168.100.220"
    ssh_password = "whitecell"
    ssh_timeout = "60m"
    ssh_username = "whitecell"
    qemu_agent = false
    template_description = "Windows Server 2019"
    template_name = "win2019-template"
    additional_iso_files {
        iso_storage_pool = "local"
        cd_files = ["preseeds/2019/autounattend.xml"]
        cd_label = "windata"
        unmount = true
    }
    boot_wait = "60s"

    boot_command = [
    "<down><wait>",
    "<enter><wait>",
    ]
}

build {
    sources = ["source.proxmox-iso.win2019"]
}
