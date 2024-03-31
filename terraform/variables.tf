variable "region" {
  description = "Region"
  default     = "us-west-2"
}

variable "aws_s3_bucket" {
  description = "aws s3 bucket"
  default     = "bucket-911"
}

variable "aws_access_key" {
  description = "My credentials"
  default     = "~/.aws/credentials/creds.json"
}

variable "aws_secret_key" {
  description = "My credentials"
  default     = "~/.aws/credentials/creds.json"
}
