resource "aws_route53_zone" "ghes_dnszone_public" {
  name = "${var.owner}.githubcsa.net"
  tags = {
    Owner = var.owner
  }
}

resource "aws_route53_record" "ghes_dnsrecord" {
  zone_id = aws_route53_zone.ghes_dnszone_public.zone_id
  name    = "ghes"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ghes_ec2.public_ip]
}