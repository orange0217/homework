output "public_ip" {
  description = "vm public ip address"
  value       = tencentcloud_instance.ubuntu[0].public_ip
}

output "private_ip" {
  description = "vm private ip address"
  value       = tencentcloud_instance.ubuntu[0].private_ip
}

output "ssh_password" {
  description = "The SSH password of instance."
  value       = var.password
}