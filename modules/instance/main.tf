resource "google_compute_instance" "rhel_instance" {
  name         = var.instance
  machine_type = var.machine_type
  zone         = var.cluster_location 
  tags         = [var.image]
 
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.vpc
   subnetwork        = var.subnet
    access_config {
    }
  }
}


