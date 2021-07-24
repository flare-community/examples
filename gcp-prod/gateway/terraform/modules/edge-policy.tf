resource "google_compute_security_policy" "edge_fw_policy" {
  project     = var.project
  name        = "edge-fw-policy"
  description = "Edge security policy. Includes blocking XSS attacks, ..."

  rule {
    action   = "deny(403)"
    priority = 1000

    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-stable')"
      }
    }
  }

  rule {
    action      = "allow"
    priority    = "2147483647"
    description = "default rule"

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}
