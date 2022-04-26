
# Inputs
variable "environment" {
  type = string
}

variable "context" {
  type    = string
}

variable "account_id" {
  type    = string
}

variable "oidc_provider" {
  type    = string
}

variable "users" {
  type    = list(string)
  default = []
}

