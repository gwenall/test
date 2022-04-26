terraform {
  required_version = ">= 1.1.6"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.11"
    }
    template = {
      source = "template"
      version = "~> 2.2"
    }
  }  
}
