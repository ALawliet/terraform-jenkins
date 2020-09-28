resource "aws_vpc" "alawliet_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy
  tags = {
    Name = "${terraform.workspace}-alawliet-vpc"
  }
}
