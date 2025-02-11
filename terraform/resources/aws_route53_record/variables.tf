variable "name" {
  type = string
}

variable "zone_id" {
  type = string
}
variable "type" {
  type = string
}
variable "allow_overwrite" {
  type = bool
}
variable "ttl" {
  type    = number
  default = 300
}

variable "records" {
  type = list(string)
}
