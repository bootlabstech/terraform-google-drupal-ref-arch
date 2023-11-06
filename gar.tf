resource "google_artifact_registry_repository" "artifact-repo" {
  count         = var.no_of_repos
  repository_id = var.name_of_repos[count.index]
  provider      = google-beta
  project       = var.project_id
  location      = var.location
  description   = var.description[count.index]
  kms_key_name  = var.kms_key_name
  format        = var.format
  mode          = var.mode
  docker_config {
    immutable_tags = var.format == "DOCKER" ? true : false
  }
  lifecycle {
    ignore_changes = [labels]
  }
}