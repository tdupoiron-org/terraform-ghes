output "ghes_ec2_public_ip" {
  value = aws_instance.ghes_ec2.public_ip
}

output "ghes_dns_record_fqdn" {
  value = "${aws_route53_record.ghes_dnsrecord.name}.${aws_route53_zone.ghes_dnszone_public.name}"
}

output "ghes_setup_endpoint" {
  value = "https://${aws_instance.ghes_ec2.public_ip}:8443/setup"
}

output "ghes_homepage" {
  value = "https://${aws_instance.ghes_ec2.public_ip}"
}

output "ghes_ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa -p 122 admin@${aws_instance.ghes_ec2.public_ip}"
}

output "ghes_admin_password" {
  value = var.ghes_admin_password
}