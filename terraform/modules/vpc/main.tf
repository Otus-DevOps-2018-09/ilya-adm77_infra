resource "google_compute_firewall" "allow_ssh" {
  name = "allow-ssh-default"

network = "default"

allow {
    protocol = "tcp"
    ports    = ["22"]
  }

target_tags = ["reddit-app","reddit-db"]

source_ranges = "${var.source_ranges}"
}
