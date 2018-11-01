variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-base-app"
}
variable private_key {
  description = "Key for provisioner connection over SSH"
}
variable db_instance_ip {

description = "DB instance ip"
}



