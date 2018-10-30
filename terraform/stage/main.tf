provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "/home/ilya0/study/git/ilya-adm77_infra/terraform/modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.instance_zone}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "/home/ilya0/study/git/ilya-adm77_infra/terraform/modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.instance_zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source        = "/home/ilya0/study/git/ilya-adm77_infra/terraform/modules/vpc"
  source_ranges = ["195.191.88.112/32"]
}
