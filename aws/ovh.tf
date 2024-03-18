resource "ovh_domain_zone_record" "ghes_lb_cert_validation_record" {
  zone      = var.ovh_domain
  subdomain = tolist(aws_acm_certificate.ghes_lb_cert.domain_validation_options)[0].resource_record_name
  fieldtype = tolist(aws_acm_certificate.ghes_lb_cert.domain_validation_options)[0].resource_record_type
  target    = tolist(aws_acm_certificate.ghes_lb_cert.domain_validation_options)[0].resource_record_value
  ttl       = 3600
}

variable "subdomains" {
  description = "List of subdomains"
  type        = list(string)
  default     = ["docker", "npm", "rubygems", "maven", "nuget", "assets", "avatars", "codeload", "gist", "media", "notebooks", "pages", "raw", "reply", "uploads", "viewscreen"]
}

resource "ovh_domain_zone_record" "ghes_subdomain_records" {
  for_each = toset(var.subdomains)

  zone      = var.ovh_domain
  subdomain = "${each.value}.${var.ghes_subdomain}"
  fieldtype = "CNAME"
  target    = "${aws_lb.ghes_lb.dns_name}."
}

resource "ovh_domain_zone_record" "ghes_domain_record" {
  zone      = var.ovh_domain
  subdomain = var.ghes_subdomain
  fieldtype = "CNAME"
  target    = "${aws_lb.ghes_lb.dns_name}."
}