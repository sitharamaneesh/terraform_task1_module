resource "google_artifact_registry_repository" "my-repo" {
  project       = var.project
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"
}


