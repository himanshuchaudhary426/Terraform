provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}


resource "aws_dynamodb_table" "emp-table" {
  provider = aws.us-east-1

  hash_key         = "empid"
  name             = "EmpTable"
  billing_mode     = "PROVISIONED"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "empid"
    type = "N"
  }

  tags = {
    Name = "EmpTable"
  }

}
