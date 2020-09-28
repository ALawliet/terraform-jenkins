provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-yoko-20200927"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
