source "proxmox-iso" "test-me" {
    memory = "4096"
    sockets = 1
    cores = 2
    cpu_type = "host"
    disks {
        disk_size = "10G"
        storage_pool = "local"
        type = "scsi"
    }
    insecure_skip_tls_verify = true
    iso_file = "local:iso/ubuntudesktopraw.iso"
    node = "r730"
    proxmox_url = "https://192.168.100.2:8006/api2/json"
    ssh_password = "1qaz2wsx!QAZ@WSX"
    ssh_timeout = "15m"
    ssh_username = "defender"
    template_description = "huh"
    template_name = "test-me"
    boot_command = [
        "<esc><wait>",
        "<esc><wait>",
        "<enter><wait>",
        "/install/vmlinuz<wait>",
        " initrd=/install/initrd.gz",
        " auto-install/enable=true",
        " debconf/priority=critical",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}./preseeds/ubuntudesktop.preseed<wait>",
        " -- <wait>",
        "<enter><wait>",
    ]
    boot_wait = "10s"
    http_directory = "."
}

build {
    sources = ["source.proxmox-iso.test-me"]
}
