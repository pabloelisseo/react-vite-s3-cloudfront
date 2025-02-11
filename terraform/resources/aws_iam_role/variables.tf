variable "name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "managed_policy_arns" {
  type    = list(string)
  default = []
}

variable "project" {
  type    = string
  default = "Unknown"
}

variable "tags" {
  type    = map(string)
  default = {}
}
