variable "project" {
  default = "Unknown"
  type    = string
}

variable "bucket" {
  type = string
}

variable "acl" {
  type    = string
  default = "public-read"
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "acceleration_status" {
  type    = string
  default = "Enabled"
}

variable "request_payer" {
  type    = string
  default = "BucketOwner"
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}
