resource "google_service_account" "service_account" {
  project    = var.project
  account_id = var.cluster.name

  display_name = var.service_account.description
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = toset(local.all_service_account_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
