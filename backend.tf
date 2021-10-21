terraform {
backend "gcs"{
bucket="dev1-cso-sec-playground-18bc_cloudbuild"
prefix="sandbox/state"
}
}
