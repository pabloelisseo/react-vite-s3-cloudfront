terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
}
provider "aws" {
  region = "eu-central-1"
}
provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}
