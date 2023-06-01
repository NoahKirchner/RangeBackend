variable "range_configuration" {
    default = {
        "win10-workstation" = {
            vm_count = 2
            name = "tf-win10-pro"
            target_node = "r730"
            clone = "Windows10Pro"
            os_type = "win10"
            sockets = 2
            cores = 2
            memory = "4096"

            disk_size = "50G"

            network_bridge = "vmbr2"
            
        }, 
    }
}
