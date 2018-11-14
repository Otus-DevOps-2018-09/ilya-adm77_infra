resource "google_compute_firewall" "allow_ssh" {
  name = "allow-ssh-default"

network = "default"

allow {
    protocol = "tcp"
    ports    = ["22"]
  }
network = "default"

target_tags = ["reddit-app","reddit-db"]

source_ranges = "${var.source_ranges}"
}
resource "google_compute_firewall" "allow_http" {
  name = "allow-http-default"

network = "default"

allow {
    protocol = "tcp"
    ports    = ["80"]
}
network = "default"

target_tags = ["reddit-app"]

source_ranges = "${var.source_ranges}"
}
