resource "aws_acm_certificate" "main" {
  domain_name               = var.domain_name
  validation_method         = var.validation_method
  subject_alternative_names = var.subject_alternative_names
  tags = {
    Project     = var.project
    Environment = terraform.workspace
  }

  lifecycle {
    create_before_destroy = true
  }
}
