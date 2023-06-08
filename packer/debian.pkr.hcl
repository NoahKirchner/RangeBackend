source "proxmox-iso" "debian" {
    vm_name = "packer-debian"
    memory = "4096"
    sockets = 1
    cores = 2
    cpu_type = "host"
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
    iso_file = "local:iso/debianraw.iso"
    node = "r730"
    proxmox_url = "https://192.168.100.2:8006/api2/json"
    ssh_password = "whitecell"
    ssh_timeout = "15m"
    ssh_username = "whitecell"
    template_description = "Debian"
    template_name = "debian-template"
    boot_command = [
        "<down><wait>",
        "<down><wait>",
        "<enter><wait>",
        "<down><wait>",
        "<down><wait>",
        "<down><wait>",
        "<down><wait>",
        "<down><wait>",
        "<down><wait>",
        "<enter><wait>",
        "<wait1m>",
        "http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseeds/debian.preseed<enter><wait>",
        "<enter><wait>",
        "<wait>",
        "whitecell<enter><wait>",
        "whitecell<enter><wait10s>",
        "<tab><enter>",
        "<wait7m>/dev/sda<enter>",
    ]
    boot_wait = "10s"
    http_directory = "."
}

build {
    sources = ["source.proxmox-iso.debian"]
}
