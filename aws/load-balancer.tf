resource "aws_acm_certificate" "ghes_lb_cert" {
  domain_name       = var.ghes_domain_name
  validation_method = "DNS"

  tags = {
    Owner = var.owner
  }
}

resource "ovh_domain_zone_record" "ghes_lb_cert_validation_record" {
  zone      = var.ovh_domain_name
  subdomain = tolist(aws_acm_certificate.ghes_lb_cert.domain_validation_options)[0].resource_record_name
  fieldtype = tolist(aws_acm_certificate.ghes_lb_cert.domain_validation_options)[0].resource_record_type
  target    = tolist(aws_acm_certificate.ghes_lb_cert.domain_validation_options)[0].resource_record_value
}

resource "aws_acm_certificate_validation" "ghes_lb_cert_validation" {
  certificate_arn         = aws_acm_certificate.ghes_lb_cert.arn
  validation_record_fqdns = [ovh_domain_zone_record.ghes_lb_cert_validation_record.subdomain]
}

resource "aws_lb" "ghes_lb" {
  name               = "${var.owner}-ghes-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ghes_sg.id]
  subnets            = [for subnet in aws_subnet.ghes_subnets : subnet.id]

  tags = {
    Owner = var.owner
  }
}

variable "ports" {
  type    = list(number)
  default = [443, 8443]
}

# Create target groups and listeners for each port
locals {
  target_group_names = [for port in var.ports : "${var.owner}-ghes-lb-tg-${port}-tf"]
}

resource "aws_lb_target_group" "ghes_lb_target_groups" {
  count       = length(var.ports)
  name        = local.target_group_names[count.index]
  port        = var.ports[count.index]
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.ghes_vpc.id
  target_type = "instance"
}

resource "aws_lb_listener" "ghes_lb_listeners" {
  count              = length(var.ports)
  load_balancer_arn  = aws_lb.ghes_lb.arn
  port               = var.ports[count.index]
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = aws_acm_certificate.ghes_lb_cert.arn

  default_action {
    target_group_arn = aws_lb_target_group.ghes_lb_target_groups[count.index].arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ghes_lb_tg_attachments" {
  count            = length(var.ports)
  target_group_arn = aws_lb_target_group.ghes_lb_target_groups[count.index].arn
  target_id        = aws_instance.ghes_ec2.id
  port             = var.ports[count.index]
}

resource "ovh_domain_zone_record" "ghes_domain_record" {
  zone      = var.ovh_domain_name
  subdomain = "ghes"
  fieldtype = "CNAME"
  target    = aws_lb.ghes_lb.dns_name
}