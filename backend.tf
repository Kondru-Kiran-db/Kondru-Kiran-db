terraform {
backend "gcs"{
bucket="tfstate-dev1-cso-sec-playground-18bc"
prefix="sandbox/state"
}
}
