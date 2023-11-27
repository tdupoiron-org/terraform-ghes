resource "aws_route53_zone" "ghes_dnszone_public" {
  name = "${var.owner}.${var.aws_region}.githubenterprise.net"
  tags = {
    Owner = var.owner
  }
}

resource "aws_route53_record" "ghes_dnsrecord" {
  zone_id = aws_route53_zone.ghes_dnszone.zone_id
  name    = "ghes"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ghes_ec2.public_ip]
}

resource "aws_route53_zone" "ghes_dnszone_private" {
  name = "${var.owner}.githubenterprise.lan"
  vpc {
    vpc_id = aws_vpc.ghes_vpc.id
  }
  tags = {
    Owner = var.owner
  }
}