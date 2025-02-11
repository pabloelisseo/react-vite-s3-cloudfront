locals {
  project  = "react-vite-app"
  domain   = "pabloelisseo.click"
  hostname = "react-vite-app.${local.domain}"
}

module "aoc" {
  source      = "../resources/aws_cloudfront_origin_access_control"
  name        = "fb-s3-cloudfront-oac"
  description = "Grant cloudfront access to s3 bucket ${module.s3_bucket.id}"
}

module "s3_bucket" {
  source = "../resources/aws_s3_bucket"
  bucket = local.project
}

module "bucket_policy" {
  source = "../resources/aws_s3_bucket_policy"
  bucket = module.s3_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_oac_access.json
}

module "cdn" {
  source     = "../resources/aws_cloudfront_distribution"
  depends_on = [module.aws_acm_certificate_validation]
  project    = local.project
  # This makes the CloudFront distribution to serve the index.html file
  default_root_object = "index.html"
  origins = [
    {
      domain_name       = module.s3_bucket.s3_domain_name
      access_control_id = module.aoc.id
      id                = "${module.s3_bucket.id}-bucket"
  }]
  default_cache_behavior = {
    compress         = true
    target_origin_id = "${module.s3_bucket.id}-bucket"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]

    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # CachingDisabled - Default ID
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac" # AllViewer - Default ID
    viewer_protocol_policy   = "redirect-to-https"
  }
  ordered_cache_behaviors = [{
    compress         = true
    path_pattern     = "/static/*"
    target_origin_id = "${module.s3_bucket.id}-bucket"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]

    # cache_policy_id          = data.aws_cloudfront_cache_policy.cloudfront_policy-caching_optimized_query_params.id
    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # CachingDisabled - Default ID
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac" # AllViewerExceptHostHeader - Default ID
    viewer_protocol_policy   = "redirect-to-https"
  }]

  # Return 200 status with index.html for 404 or 403 errors -> SPA client-side routing
  custom_error_responses = [{
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
    }, {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }]

  cloudfront_default_certificate = false
  acm_certificate_arn            = module.cloudfront-acm_certificate.arn
  aliases                        = [local.hostname]
}

module "dns-route53_alias_record" {
  source  = "../resources/aws_route53_alias_record"
  zone_id = data.aws_route53_zone.main.id
  name    = local.hostname
  alias = {
    name                   = module.cdn.domain_name
    zone_id                = module.cdn.hosted_zone_id
    evaluate_target_health = true
  }
}

module "cloudfront-acm_certificate" {
  providers = {
    aws = aws.us-east-1
  }
  source            = "../resources/aws_acm_certificate"
  project           = local.project
  domain_name       = local.hostname
  validation_method = "DNS"
}

module "aws_route53_record" {
  source = "../resources/aws_route53_record"
  for_each = {
    for dvo in [for each in module.cloudfront-acm_certificate.domain_validation_options : each] : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
  allow_overwrite = true
}

module "aws_acm_certificate_validation" {
  providers = {
    aws = aws.us-east-1
  }
  source                  = "../resources/aws_acm_certificate_validation"
  certificate_arn         = module.cloudfront-acm_certificate.arn
  validation_record_fqdns = [for record in module.aws_route53_record : record.fqdn]
}

