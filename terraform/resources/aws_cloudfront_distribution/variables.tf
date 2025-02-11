variable "project" {
  default     = "Unknown"
  type        = string
  description = "Name of project"
}
variable "default_root_object" {
  default     = ""
  type        = string
  description = "Default root object"
}

variable "origins" {
  type = list(object({
    domain_name       = string,
    id                = string,
    access_control_id = optional(string),
    custom_configs = optional(list(object({
      http_port       = number,
      https_port      = number,
      protocol_policy = string,
      ssl_protocols   = list(string),
    })), [])
  }))
  description = "Aplication Load Balancer ARN"
}
variable "cloudfront_default_certificate" {
  type        = bool
  description = "Whether or not you want viewers to use HTTPS to request your objects"
  default     = true
}
variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution"
  default     = ""
}
variable "aliases" {
  type        = list(any)
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  default     = []
}

variable "default_cache_behavior" {
  type = object({
    compress                 = bool
    target_origin_id         = string
    allowed_methods          = list(string)
    cached_methods           = list(string)
    cache_policy_id          = string
    origin_request_policy_id = string
    viewer_protocol_policy   = string
    lambda_function_associations = optional(list(object({
      event_type   = string
      lambda_arn   = string
      include_body = bool
    })), [])
  })
  description = "Cloudfront's custom cache behaviors"
}
variable "ordered_cache_behaviors" {
  type = list(object({
    compress                 = bool
    path_pattern             = string
    target_origin_id         = string
    allowed_methods          = list(string)
    cached_methods           = list(string)
    cache_policy_id          = string
    origin_request_policy_id = string
    viewer_protocol_policy   = string
    lambda_function_associations = optional(list(object({
      event_type   = string
      lambda_arn   = string
      include_body = bool
    })), [])
  }))
  description = "Cloudfront's custom cache behaviors"
  default     = []
}

variable "custom_error_responses" {
  type = list(object({
    error_code         = number
    response_code      = number
    response_page_path = string
  }))
  description = "Cloudfront's custom error responses"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}
