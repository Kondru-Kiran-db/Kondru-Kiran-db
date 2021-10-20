provider "google" {
project = "dev1-cso-sec-playground-18bc"
region = "europe-west2"
zone = "europe-west2-c"
}

resource "google_compute_network" "vpc_network" {
project = "dev1-cso-sec-playground-18bc"
name = "test-network"
auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "network-test" {
project = "dev1-cso-sec-playground-18bc"
name = "test-subnetwork"
ip_cidr_range = "10.10.1.0/24"
region = "europe-west2"
network = "test-network"
}

resource "google_compute_firewall" "default" {
name = "vpc-test-firewall"
network = "test-network"

allow {
protocol = "icmp"
}

allow {
protocol = "tcp"
ports = ["22"]
}

source_ranges = ["10.10.1.0/24",
"35.235.240.0/20"]
}

resource "google_compute_router" "router" {
name = "test-router"
region = "europe-west2"
network = "test-network"
}

resource "google_compute_router_nat" "nat" {
name = "test-router-nat"
router = "test-router"
region = "europe-west2"
nat_ip_allocate_option = "AUTO_ONLY"
source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_instance" "vm_instance" {
project = "dev1-cso-sec-playground-18bc"
zone = "europe-west2-c"
name = "test-os-micro-1"
machine_type = "f1-micro"

boot_disk {
initialize_params {
image = "debian-cloud/debian-9"
}
}

network_interface {
subnetwork = "test-subnetwork"
}

}

resource "google_storage_bucket" "dev-bucket" {
name = "test-bucket"
project = "dev1-cso-sec-playground-18bc"
location = "europe-west2"
uniform_bucket_level_access = true
force_destroy = true
}
