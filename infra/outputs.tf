output "public_ip_address" {
  description = "public ip address"
  value       = [aws_instance.microserviceFront.public_ip,aws_instance.microserviceFront2.public_ip]
}
