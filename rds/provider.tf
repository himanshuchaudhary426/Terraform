provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}
