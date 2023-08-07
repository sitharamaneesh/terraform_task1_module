module "vpc" {
  source = "../modules/vpc"
  project = var.project
  region = var.region
  network_name = var.network_name
  subnet_ip_cidr_range = var.subnet_ip_cidr_range
  subnet_name = var.subnet_name
#  cluster_secondary_range_name = var.cluster_secondary_range_name
#  services_secondary_range_name = var.services_secondary_range_name
}

module "gke" {
  source = "../modules/gke"
  project = var.project
  region = var.region
  cluster_name = var.cluster_name
  network = module.vpc.network_name
  subnetwork = module.vpc.subnet_name
  node_count = var.node_count
  machine_type = var.machine_type
  oauth_scopes = var.oauth_scopes
  node_pool_name = var.node_pool_name
  enable_private_nodes = var.enable_private_nodes
  enable_private_endpoint = var.enable_private_endpoint
  master_ipv4_cidr_block = var.master_ipv4_cidr_block
  cluster_ipv4_cidr_block = var.cluster_ipv4_cidr_block
  services_ipv4_cidr_block = var.services_ipv4_cidr_block
  disk_size_gb = var.disk_size_gb
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 1.2"
  project_id = var.project
  region     = var.region
  router     = module.nat.name
  name       = var.nat

}

module "artifact_registry" {
  source        = "../modules/artifact_registry"
  project       = var.project
  location      = var.region
  repository_id = var.repository_id
}

module "instance" {
  source       = "../modules/instance" {
  name         = var.insatnce
  machine_type = var.machine_type
  zone         = var.cluster_location
  tags         = var.image
  image        = var.image
  network      = module.vpc.network_name
  subnetwork   = module.vpc.subnet_name
}

module "firewall" {
  source       = "../modules/firewall"
  project      = var.project  
  name         = var.firewall
  network      = module.vpc.network_name
  protocol     = var.protocol
  ports        = var.ports
  source_ranges = var.source_ranges
}
  
module "service_account" {
  source       =  "../modules/service_account"
  account_id   = var.account_id
  project      = var.project
}



