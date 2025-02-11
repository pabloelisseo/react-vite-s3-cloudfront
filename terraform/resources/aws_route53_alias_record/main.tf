resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"
  alias {
    name                   = var.alias.name
    zone_id                = var.alias.zone_id
    evaluate_target_health = var.alias.evaluate_target_health
  }
}
