resource "google_compute_firewall" "rules" {
  project = var.project
  name    = var.firewall
  network = var.vpc # Replace with a reference or self link to your network, in quotes

  allow {
    protocol = var.protocol
    ports    = [var.ports]
  }
  source_ranges = [var.source_ranges]
}

