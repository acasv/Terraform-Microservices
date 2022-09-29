output "public_ip_address" {
  description = "public ip address"
  value       = module.deployEC2.public_ip_address
}