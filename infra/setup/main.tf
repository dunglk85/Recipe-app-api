terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }

  backend "s3" {
    bucket         = "recipe-ap-tf-state"
    key            = "tf-state-setup"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "recipe-app-tf-lock"
  }
}

provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      ManageBy    = "Terraform/setup"
    }
  }
}