output "ghes_public_ip" {
  value = aws_instance.ghes_ec2.public_ip
}

output "ghes_setup_endpoint" {
  value = "https://${aws_instance.ghes_ec2.public_ip}:8443/setup"
}

output "ghes_homepage" {
  value = "https://${aws_instance.ghes_ec2.public_ip}"
}

output "ghes_ssh_command" {
  value = "ssh -i ~/.ssh/${var.key_pair_name}.pem -p 122 admin@${aws_instance.ghes_ec2.public_ip}"
}

output "ghes_admin_password" {
  value = var.ghes_admin_password
}