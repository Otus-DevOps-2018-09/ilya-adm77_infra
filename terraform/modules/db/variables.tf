variable db_disk_image {
description = "Disk image for reddit db"
default = "reddit-base-db"
}
variable instance_zone {
  description = "Define zone for VM instance"
}
variable public_key_path {
description = "Path to the public key used to connect to instance"
}
