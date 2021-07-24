variable "project" {
  type        = string
  description = "GCP unique project id"
}

variable "dns_entries" {
  type        = set(string)
  description = "List of unique names to create a records."
}

variable "name" {
  type        = string
  description = "Static ip name"
  default     = "toptal"
}
