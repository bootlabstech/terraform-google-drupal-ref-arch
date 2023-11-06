resource "google_container_registry" "mpaasreg" {
  project  = var.project_id
  location = var.gcr_location
  lifecycle {
    ignore_changes = []
  }
}