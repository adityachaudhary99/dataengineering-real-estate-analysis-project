terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3_bucket

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}