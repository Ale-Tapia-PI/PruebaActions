variable "env" {
  description = "Deployment environment"
  default     = "dev"
}

variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "name_prefix" {
  description = "Prefix for role name"
  default     = "PDP"
}

variable "name_suffix" {
  description = "Prefix for role name"
  default     = "testing"
}

variable "origin" {
  description = "The origin of the repository"
  default     = "GITHUB"
}

variable "repository_branch" {
  description = "Repository branch to connect to"
  default     = "develop"
}

variable "repository_owner" {
  description = "GitHub repository owner"
  default     = "Ale-Tapia-PI"
}

variable "repository_name" {
  description = "GitHub repository name"
  default     = " PruebaActions"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "pureinsights-testingv1"
}

variable "github_token" {
  description = "Token for github access"
}