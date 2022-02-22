terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  region     = "us-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
  profile    = "alejandro.tapia"
}