provider "google" {
  credentials = "${file("service-account.json")}"
  project     = "terraform-instance"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name                      = "terraform-instance"
  machine_type              = "f1-micro"

  metadata = {
    ssh-keys  = "dm:${file("terraform-instance.pub")}"
  }

  boot_disk {
    initialize_params {
      image   = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network   = "default"
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                      = "terraform-network"
  auto_create_subnetworks   = "true"
}