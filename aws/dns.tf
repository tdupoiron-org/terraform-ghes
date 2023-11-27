
resource "aws_route53_zone" "ghes_route53" {
  name = "${var.owner}.ghes.${var.aws_region}.githubenterprise.net"
  tags = {
    Owner = var.owner
  }
}