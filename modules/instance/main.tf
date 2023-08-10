resource "google_compute_instance" "rhel_instance" {
  name         = var.instance
  machine_type = var.machine_type
  zone         = var.zone 
 
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network
   subnetwork        = var.subnetwork
    access_config {
    }
  }
}


