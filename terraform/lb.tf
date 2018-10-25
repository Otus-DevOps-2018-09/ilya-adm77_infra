
resource "google_compute_instance_group" "group1" {
  name        = "reddit-app"
  description = "Terraform test instance group"

  instances = [
   "${google_compute_instance.app.*.self_link}",
#   "${google_compute_instance.app1.*.self_link}"
]

  zone = "europe-west1-b"
  named_port {
    name = "http"
    port = "9292"
  }
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

