provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}
resource "google_compute_instance" "app1" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.instance_zone}"
  tags         = ["reddit-app"]
  count        = "2"
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"

}

  network_interface {
    network       = "default"
    access_config = {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}


resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.instance_zone}"
  tags         = ["reddit-app"]
  count        = "2"
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"

}

  network_interface {
    network       = "default"
    access_config = {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}
resource "google_compute_project_metadata_item" "ssh-key-1" {
  key   = "ssh-keys"
  value = "appuser1:${file(var.public_key_path)}"
}
resource "google_compute_project_metadata_item" "ssh-key-2" {
  key   = "ssh-keys"
  value = "appuser3:${file(var.public_key_path)}"
}

#========================================================

resource "google_compute_instance_group" "group1" {
  name        = "reddit-app"
  description = "Terraform test instance group"

  instances = [
   "${google_compute_instance.app.*.self_link}",
   "${google_compute_instance.app1.*.self_link}"
]

  named_port {
    name = "http"
    port = "9292"
  }
  zone = "europe-west1-b"
}
resource "google_compute_health_check" "internal-health-check" {
 name = "internal-service-health-check"

 timeout_sec        = 1
 check_interval_sec = 1

 tcp_health_check {
   port = "9292"
 }
}
resource "google_compute_backend_service" "backend1" {
  name = "backend1"
  backend {
  group = "${google_compute_instance_group.group1.self_link}"
  }

  health_checks = ["${google_compute_health_check.internal-health-check.self_link}"]
}
resource "google_compute_url_map" "urlmap" {
  name        = "urlmap"
  description = "url map for load balancer"

  default_service = "${google_compute_backend_service.backend1.self_link}"
}
resource "google_compute_target_http_proxy" "default" {
  name             = "test-proxy"
  url_map          = "${google_compute_url_map.urlmap.self_link}"
}
resource "google_compute_global_forwarding_rule" "default" {
  name       = "default-rule"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80"
}
