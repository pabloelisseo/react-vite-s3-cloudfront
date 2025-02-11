variable "name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "alias" {
  type = object({
    name                   = string
    zone_id                = string
    evaluate_target_health = bool
  })
}
