### cloud storage bucket
resource "google_storage_bucket" "tftest-kiran-bucket" {
  name = var.storage_bucket_name
  project = var.project_id
  uniform_bucket_level_access = true
  versioning {
   enabled = true
  }
}
