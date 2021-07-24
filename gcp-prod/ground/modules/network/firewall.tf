//https://cloud.google.com/load-balancing/docs/health-checks#firewall_rules
resource "google_compute_firewall" "allow_gc_health_checks" {
  project   = var.vpc.project
  name      = "${var.vpc.name}-allow-internal-networks"
  network   = google_compute_network.vpc.self_link
  priority  = 1000
  direction = "INGRESS"

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

#https://cloud.google.com/monitoring/uptime-checks/
resource "google_compute_firewall" "allow_stackdriver_uptime_checks" {
  project   = var.vpc.project
  name      = "${var.vpc.name}-allow-stackdriver-uptime-checks"
  network   = google_compute_network.vpc.self_link
  priority  = 1000
  direction = "INGRESS"

  source_ranges = [
    "35.187.242.246",
    "35.186.144.97",
    "35.198.221.49",
    "35.198.194.122",
    "35.198.248.66",
    "35.185.178.105",
    "35.198.224.104",
    "35.240.151.105",
    "35.186.159.51",
    "146.148.59.114",
    "23.251.144.62",
    "146.148.41.163",
    "35.239.194.85",
    "104.197.30.241",
    "35.192.92.84",
    "35.238.3.7",
    "35.224.249.156",
    "35.238.118.210",
    "35.197.117.125",
    "35.203.157.42",
    "35.199.157.7",
    "35.233.206.171",
    "35.197.32.224",
    "35.233.167.246",
    "35.203.129.73",
    "35.185.252.44",
    "35.233.165.146",
    "35.186.164.184",
    "35.188.230.101",
    "35.199.27.30",
    "35.186.176.31",
    "35.236.207.68",
    "35.236.221.2",
    "35.221.55.249",
    "35.199.12.162",
    "35.186.167.85",
    "104.155.77.122",
    "104.155.110.139",
    "146.148.119.250",
    "35.195.128.75",
    "35.240.124.58",
    "35.205.234.10",
    "35.205.72.231",
    "35.187.114.193",
    "35.205.205.242",
    "35.199.66.47",
    "35.198.18.224",
    "35.199.67.79",
    "35.198.36.209",
    "35.199.90.14",
    "35.199.123.150",
    "35.198.39.162",
    "35.199.77.186",
    "35.199.126.168",
  ]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }
}
