data "aws_dynamodb_table" "emptable" {
  name = "EmpTable"
}


resource "aws_dynamodb_table_item" "EmpTable-item" {
  table_name = data.aws_dynamodb_table.emptable.name
  hash_key   = data.aws_dynamodb_table.emptable.hash_key

  item = <<ITEM
{
  "empid": {"N": "1375"},
  "firstname": {"S": "Himanshu"},
  "lastname": {"S": "Chaudhary"},
  "age": {"N": "21"},
  "dob": {"S": "13/05/1998"}
}
ITEM
}
