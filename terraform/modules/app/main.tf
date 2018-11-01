data "template_file" "puma" {
  template = "${file("${var.file_path}/puma.service")}"

  vars {
    db_ip = "${var.db_instance_ip}"
  }
}
 
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

 boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
}
  network_interface {
    network = "default"

    access_config = {nat_ip = "${google_compute_address.app_ip.address}"}
  }
  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
 
connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key)}"
  }
provisioner "file" {
    content = "${data.template_file.puma.rendered}"
    destination = "/tmp/puma.service"
  }

provisioner "remote-exec" {

    script = "${var.file_path}/deploy.sh"
} 

}
resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

