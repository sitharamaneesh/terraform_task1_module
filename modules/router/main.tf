resource "google_compute_router" "router" {
  project = var.project
  name    = var.nat
  network = var.vpc 
  region  = var.region
}

