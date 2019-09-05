data "aws_caller_identity" "this" {}
data "aws_region" "current" {}

resource "aws_route53_zone" "subdomain" {
  name = "${var.subdomain}.${var.root_domain_name}."
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

//  domain_name  = var.root_domain_name
  domain_name = "${var.subdomain}.${var.root_domain_name}"
  zone_id      = aws_route53_zone.subdomain.zone_id

  subject_alternative_names = [
    "${var.subdomain}.${var.root_domain_name}"
  ]

  tags = {
    Name = var.root_domain_name
  }
}