provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}
