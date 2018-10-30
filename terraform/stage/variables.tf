variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key {
  description = "Key for provisioner connection over SSH"
}

variable instance_zone {
  description = "Define zone for VM instance"
  default     = "europe-west1-b"
}

variable "instance_name" {
  default = {
    "0" = "reddit-app"
    "1" = "reddit-app1"
  }
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-base-app"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}
