output "ghes_ec2_public_ip" {
  value = aws_instance.ghes_ec2.public_ip
}

output "ghes_ec2_public_dns" {
  value = aws_instance.ghes_ec2.public_dns
}

output "ghes_setup_endpoint" {
  value = "https://${aws_instance.ghes_ec2.public_dns}:8443/setup"
}

output "ghes_homepage" {
  value = "https://${aws_instance.ghes_ec2.public_dns}"
}

output "ghes_ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa -p 122 admin@${aws_instance.ghes_ec2.public_dns}"
}

output "ghes_admin_password" {
  value = var.ghes_admin_password
}

output "ghes_lb_dns" {
  value = aws_lb.ghes_lb.dns_name
}