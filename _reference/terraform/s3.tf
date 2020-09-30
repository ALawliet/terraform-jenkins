resource "aws_s3_bucket" "my_bucket" {
  bucket = var.my_app_s3_bucket
  acl    = "private"
  #   region = "us-east-1"
  #   provider = "aws.aws_region"

  tags = {
    Name        = "name tag"
  }
}