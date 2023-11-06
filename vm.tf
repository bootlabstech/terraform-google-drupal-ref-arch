resource "google_compute_instance" "default" {
  count                         = var.no_of_instances
  name                          = var.name_of_instances[count.index]
  machine_type                  = var.machine_type
  zone                          = var.zone
  project                       = var.project_id
  tags                          = var.tags
  min_cpu_platform              = var.min_cpu_platform
  advanced_machine_features {
  enable_nested_virtualization  = var.enable_nested_virtualization
  threads_per_core              = var.threads_per_core
  }

 
  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.boot_disk_image
    }
    kms_key_self_link = var.kms_key_self_link == "" ? null : var.kms_key_self_link
  }


  // Allow the instance to be stopped by terraform when updating configuration
  allow_stopping_for_update = var.allow_stopping_for_update
 
 metadata = {
  enable-oslogin = var.enable_oslogin
  windows-startup-script-ps1 = var.is_os_linux ? null : templatefile("${path.module}/windows_startup_script.tpl", {})

  # Exclude startup_script key when using the Windows startup script
  startup-script = var.is_os_linux ? templatefile("${path.module}/linux_startup_script.tpl", {}) : null
}
  network_interface {
    subnetwork = var.subnetwork
  }

  dynamic "service_account" {
    for_each = var.create_service_account ? [{}] : []

    content {
      email  = google_service_account.default[0].email
      scopes = var.service_account_scopes
    }
  }

  shielded_instance_config {
    enable_secure_boot          = var.enable_secure_boot
    enable_integrity_monitoring = var.enable_integrity_monitoring
  }

  timeouts {
    create = "10m"
  }

  lifecycle {
    ignore_changes = [attached_disk,labels,tags]
  }

}
 
resource "google_service_account" "default" {
  count        = var.create_service_account ? 1 : 0
  account_id   = "service-account-id"
  project      = var.project_id
}

resource "google_compute_address" "static" {
  count        = var.address_type == "INTERNAL" ? (var.address == "" ? 0 : 1) : 1
  name         = "compute-address"
  project      = var.compute_address_project
  region       = var.compute_address_region
  address_type = var.address_type
  subnetwork   = var.subnetwork
  address      = var.address_type == "INTERNAL" ? (var.address == "" ? null : var.address) : null
}
resource "google_compute_resource_policy" "daily" {
  project = var.project_id
  name   = "gcp-vm-backup-policy"
  region = "asia-south1"
  snapshot_schedule_policy {

    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "01:00"
      }
    }
    retention_policy {
      max_retention_days    = 7
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      storage_locations = ["asia"]
      guest_flush       = true
      # chain_name = "vm-schedule-chain"
    }
  }
}