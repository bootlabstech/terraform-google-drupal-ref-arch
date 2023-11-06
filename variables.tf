#GAR
variable "project_id" {
  type        = string
  description = "Name of the project"
}
variable "location" {
  type        = string
  description = "Name of the location this repository is located in."
}
variable "no_of_repos" {
  type        = number
  description = "Number of the repositories  in the artifact registry"
}
variable "name_of_repos" {
  type        = list(string)
  description = "Name of the repository id in the artifact registry"
}
variable "description" {
  type        = list(string)
  description = "The user-provided description of the repository."
}
variable "kms_key_name" {
  type        = string
  description = "Name of the kms key artifact_registry_repository"
}
variable "format" {
  type        = string
  description = "The format of packages that are stored in the repository.eg Docker Image Manifest V2, Schema 1, Docker Image Manifest V2, Schema 2,Open Container Initiative (OCI)"
}
variable "mode" {
  type        = string
  description = "The mode of the repository.Possible values are: STANDARD_REPOSITORY, VIRTUAL_REPOSITORY, REMOTE_REPOSITORY."
  default     = "STANDARD_REPOSITORY"
}
#GCR - non needed.
variable "gcr_location" {
  type        = string
  description = "Name of the location this repository is located in."
}
#GCS
variable "no_of_buckets" {
  description = "the number of the new buckets that will be created"
  type        = number
}
variable "name_of_buckets" {
  type = list(string)
}
variable "force_destroy" {
  description = "option to delete all objects in a bucket while deleting a bucket"
  type        = bool
  default     = false
}

variable "storage_class" {
  description = "the Storage Class of the new bucket"
  type        = string
  default     = null
}

variable "labels" {
  description = "a map of key/value label pairs to assign to the bucket"
  type        = map(string)
  default     = null
}

variable "uniform_bucket_level_access" {
  description = "enables uniform bucket level access to a bucket"
  type        = bool
  default     = true
}

variable "lifecycle_rule" {
  description = "lifecycle rule for a gcs bucket"
  type = list(object({
    action    = any
    condition = any
  }))
  default = []
}

variable "bucket_object_versioning" {
  description = "enabling versioning can help retain a noncurrent object version"
  type        = bool
  default     = true
}

variable "cors" {
  description = "cors configuration for the bucket"
  type        = any
  default     = []
}

variable "retention_policy" {
  description = "configuration of the bucket's data retention policy for how long objects in the bucket should be retained"
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default = null
}

variable "log_object_bucket" {
  description = "a gcs bucket that can receive log objects"
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "the object prefix for log objects which defaults to gcs bucket name"
  type        = string
  default     = null
}

variable "encryption" {
  description = "a cloud KMS key that will be used to encrypt objects inserted into this bucket"
  type = object({
    kms_key_name = string
  })
  default = null
}
# Cloud SQL
variable "db_root_username" {
  type        = string
  description = "The root username for the database instance"
}

variable "dbinstance_name" {
  description = "The name of the database instance"
  type        = string
}

variable "database_version" {
  description = "The MySQL, PostgreSQL or SQL Server version to use. Supported values include MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6,POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB. SQLSERVER_2019_STANDARD, SQLSERVER_2019_ENTERPRISE, SQLSERVER_2019_EXPRESS, SQLSERVER_2019_WEB"
  type        = string
}

variable "region" {
  description = "The region the instance will sit in"
  type        = string
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance"
  type        = bool
}

variable "tier" {
  description = "The machine type to use"
  type        = string
}

variable "availability_type" {
  description = "The availability type of the Cloud SQL instance, high availability (REGIONAL) or single zone (ZONAL)"
  type        = string
}

variable "disk_size" {
  description = "The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased"
  type        = string
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size automatically"
  type        = bool
}

variable "backup_enabled" {
  description = "True if backup configuration is enabled"
  type        = bool
}

variable "binary_log_enabled" {
  description = "True if backup configuration is enabled"
  type        = bool
}

variable "ipv4_enabled" {
  description = "True if backup configuration is enabled"
  type        = bool
  default     = false
}

variable "backup_start_time" {
  description = "HH:MM format time indicating when backup configuration starts"
  type        = string
}

variable "database_flags" {
  description = "The id of the vpc"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "insights_config" {
  description = "The id of the vpc"
  type = list(object({
    query_insights_enabled  = bool
    query_string_length     = number
    record_application_tags = bool
    record_client_address   = bool
  }))
}

variable "maintenance_window" {
  description = "Subblock for instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates"
  type = list(object({
    maintenance_window_day          = number
    maintenance_window_hour         = number
    maintenance_window_update_track = string
  }))
}

variable "shared_vpc_project_id" {
  description = "Shared VPC project"
  type        = string
}


variable "private_ip_address_name" {
  description = "The name of the static private ip for the database"
  type        = string
}

variable "reserved_peering_ranges" {
  description = "List of peering ranges"
  type        = string
}
variable "authorized_network" {
  description = "authorized_network"
  type        = string
}
variable "host_project_id" {
  description = "host_project_id"
  type        = string
}

variable "encryption_key_name" {
  type        = string
  description = "the Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool"
  default     = ""
}

#VM

// required variables

variable "no_of_instances" {
  type        = number
  description = "The number of instances to be created."
}
variable "name_of_instances" {
  type        = list(string)
  description = "The name of instances to be created."
}
variable "machine_type" {
  type        = string
  description = "The type of machine to be created."
}
variable "zone" {
  type        = string
  description = "The zone of the VM."
}
variable "boot_disk_size" {
  type        = number
  description = "The boot_disk_size of the VM."
}
variable "boot_disk_type" {
  type        = string
  description = "The boot_disk_type of the VM."
}
variable "boot_disk_image" {
  type        = string
  description = "The boot_disk_image of the VM."
}

variable "compute_address_region" {
  type        = string
  description = "The region that the compute address should be created in. If it is not provided, the provider zone is used."
}
variable "compute_address_project" {
  type        = string
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}
variable "is_os_linux" {
  type        = bool
  description = "Executes different metadata scripts on this basis."
}
variable "min_cpu_platform" {
  type        = string
  description = "Intel Skylake or Intel Haswell"
}
variable "enable_secure_boot" {
  type        = bool
  default     = true
}
variable "enable_integrity_monitoring" {
  type        = bool
  default     = true
}
variable "enable_oslogin" {
  type        = string
  default     = "TRUE"
}
variable "enable_nested_virtualization" {
  type        = bool
  description = "enable_nested_virtualization"
  default     = false
}
variable "threads_per_core" {
  type        = number
  description = "the number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1"
  default     = 1
}

// optional variables

variable "tags" {
  type        = list(string)
  description = "A list of network tags to attach to the instance."
  default     = []
}

variable "network" {
  type        = string
  description = " The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
}

variable "subnetwork" {
  type        = string
  description = "The name or self_link of the subnetwork to attach this interface to. Either network or subnetwork must be provided."
}
variable "enable_startup_script" {
  type        = bool
  description = "Enable startup script, include startup.sh"
  default     = false
}
variable "create_service_account" {
  type        = bool
  description = "Create service account for the compute instance"
  default     = false
}
variable "service_account_scopes" {
  type        = list(string)
  description = "A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope."
  default     = ["cloud-platform"]
}
variable "allow_stopping_for_update" {
  type        = bool
  description = "If true, allows Terraform to stop the instance to update its properties. If you try to update a property that requires stopping the instance without setting this field, the update will fail."
  default     = true
}
variable "kms_key_self_link" {
  type        = string
  description = "The self_link of the encryption key that is stored in Google Cloud KMS to encrypt this disk."
  default     = ""
}
variable "additional_disk_needed" {
  type        = bool
  description = "Is Additional disk needed."
}

variable "address_type" {
  type        = string
  description = "The type of address to reserve. Default value is EXTERNAL. Possible values are INTERNAL and EXTERNAL"
}
variable "address" {
  type        = string
  description = "The private ip of the compute-instance"
  default      = ""
}
# schedule-instance-start-stop
# variable "resource_policy" {
#   type        = string
#   description = " The name of sceduled policy should be created"
# }

# variable "description" {
#   type        = string
#   description = "The name of start and stop"
# }

# variable "time_zone" {
#   type        = string
#   description = "the time zone to be used in interpreting the schedule"
# }

# variable "vm-scheduled_start" {
#   type        = string
#   description = "The schedule for starting instances."
# }

# variable "vm-scheduled_stop" {
#   type        = string
#   description = "the schedule for stopping instances"
# }

# variable "scheduling_enabled" {
#   type        = bool
#   description = "The schedule vm is need to be true but the default is false"
#   default     = false
# }
# variable "additional_disk_name" {
#   type        = string
#   description = "The schedule vm is need to be true but the default is false"

# }
# variable "gpu_type" {
#   description = ""
#   type = string
  
# }
# variable "gpu_count" {
#   description = ""
#   type = number
  
# }

#GKE 

// required variables
variable "name" {
  type        = string
  description = "this name will be used as prefix for all the resources in the module"
}

variable "subnet" {
  type        = string
  description = "this is the subnet for the cluster"
}

variable "default_node_pool_min_count" {
  type        = number
  description = "this is the min count in the default node pool"
}

variable "default_node_pool_max_count" {
  type        = number
  description = "this is the max count in the default node pool"
}

variable "gke_machine_type" {
  type        = string
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
    "f2-micro",
    "e3-micro",
    "e2-small",
    "g1-small",
    "e2-medium",
    "t2d-standard-1"
   ],
   "description": "regions used for deployment"
}
EOT
}

variable "image_type" {
  type        = string
  default     = "cos_containerd"
  description = "the default image type used by NAP once a new node pool is being created"
}

variable "preemptible" {
  type        = bool
  description = "if set to true, the secondary node pool will be preemptible nodes"
}

variable "boot_disk_kms_key" {
  type        = string
  description = "the Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool"
  default     = ""
}

// optional variables
variable "service_account_id" {
  type        = string
  description = "the id is used as a postfix in service account created for the kubernetes engine"
  default     = "gke-sa"
}

variable "cluster_postfix" {
  type        = string
  description = "this will be used as the postfix for the cluster name, along with var.name"
  default     = "gke-k8s"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "the master network ip range"
  # default     = "172.16.0.32/28"
}

variable "enable_private_cluster" {
  type        = bool
  description = "if enabled cluster becomes a private cluster"
  default     = true
}

variable "enable_private_googleapis_route" {
  type        = bool
  description = "enable route for private google service"
  default     = false
}

variable "create_private_dns_zone" {
  type        = bool
  description = "enable dns for private google service"
  default     = false
}

variable "enable_private_googleapis_firewall" {
  type        = bool
  description = "enable firewall for private google service"
  default     = false
}

variable "enable_cloud_nat" {
  type        = bool
  description = "if enabled cloud nat will be created for private clusters"
  default     = false
}

variable "is_shared_vpc" {
  type        = bool
  description = "if the vpc and subnet is from a shared vpc"
  default     = false
}

variable "services_secondary_range_name" {
  type        = string
  description = "the secondary range name of the subnet to be used for services, this is needed if is_shared_vpc is enabled"
  default     = ""
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "the secondary range name of the subnet to be used for pods, this is needed if is_shared_vpc is enabled"
  default     = ""
}

variable "subnet_region" {
  type        = string
  description = <<-EOT
  {
   "type": "api",
   "purpose": "autocomplete",
   "data":"api/gcp/regions",
   "description": "regions used for deployment"
}
EOT
  default     = ""
}

variable "enable_shielded_nodes" {
  type        = bool
  default     = true
  description = "Enable Shielded Nodes features on all nodes in this cluster"
}

variable "workload_identity" {
  type        = bool
  default     = true
  description = "to enable workload identity metadata"
}

variable "enable_intranode_visibility" {
  type        = bool
  default     = true
  description = "to enable intra node visibility for the cluster"
}

variable "remove_default_node_pool" {
  type        = bool
  default     = true
  description = " If true, deletes the default node pool upon cluster creation. If you're using google_container_node_pool resources with no default node pool, this should be set to true, alongside setting initial_node_count to at least 1"
}

variable "oauth_scopes" {
  type        = list(string)
  description = "oauth scopes for gke cluster"
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

# variable "enable_binary_authorization" {
#   type        = bool
#   default     = true
#   description = "to enable binary authorization"
# }

variable "node_locations" {
  type        = list(string)
  description = "The list of zones in which the cluster's nodes are located. Nodes must be in the region of their regional cluster or in the same region as their cluster's zone for zonal clusters. If this is specified for a zonal cluster, omit the cluster's zone."
  default     = []
}

variable "containerAdminMembers" {
  type        = list(string)
  description = "The list of members who will have container admin role."
  default     = []
}

variable "cluster_default_max_pods_per_node" {
  type        = number
  description = "The default maximum number of pods per node in this cluster. See the official documentation for more information"
  default     = 64
}

variable "primary_node_pool_max_pods_per_node" {
  type        = number
  description = "The maximum number of pods per primary node in this node pool"
  default     = 64
}


variable "enable_release_channel" {
  type        = bool
  description = "Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters"
  default     = true
}

variable "release_channel" {
  type        = string
  description = "The selected release channel"
}

variable "initial_node_count" {
  type = string
  description = "(optional) describe your variable"
}
