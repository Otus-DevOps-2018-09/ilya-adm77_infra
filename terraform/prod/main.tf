provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}
data "terraform_remote_state" "gcs1" {
  backend = "gcs"
config {
   bucket = "bucket-reddit-app"
  }
  }

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.instance_zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.instance_zone}"
  app_disk_image  = "${var.app_disk_image}"
  private_key     = "${var.private_key}"
  db_instance_ip  = "${module.db.db_external_ip}"
}


module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
