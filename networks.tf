resource "google_compute_network" "my_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "windows_subnet" {
  name          = "windows-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.my_network.self_link
  region        = "us-central1"
}

resource "google_compute_subnetwork" "linux_subnet" {
  name          = "linux-subnet"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.my_network.self_link
  region        = "us-central1"
}

resource "google_compute_firewall" "allow_ssh_windows" {
  name    = "allow-ssh-windows"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh_linux" {
  name    = "allow-ssh-linux"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}