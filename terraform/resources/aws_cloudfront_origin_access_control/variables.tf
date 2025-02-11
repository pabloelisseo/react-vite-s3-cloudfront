variable "name" {
  type = string
}
variable "description" {
  type = string
}
variable "origin_access_control_origin_type" {
  type    = string
  default = "s3"
}
variable "signing_behavior" {
  type    = string
  default = "always"
}
variable "signing_protocol" {
  type    = string
  default = "sigv4"
}
