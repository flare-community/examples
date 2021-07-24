output "vpc" {
  value = module.dev_network.vpc
}

output "vpc_name" {
  value = module.dev_network.vpc_name
}

output "subnetworks" {
  value = module.dev_network.subnetworks
}
