resource "aws_vpc" "sri_dynamo" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sri_dynamodb"
  }
}

resource "aws_subnet" "sridb_sub" {
  vpc_id            = aws_vpc.sri_dynamo.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1c"

}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Mydb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"
  range_key      = "GameTitle"

  attribute {
    name = "LockID"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}

resource "aws_iam_user" "my_iam" {
  user_name = "sri_iamuser"
} 
resource "aws_iam_access_key" "lb" {
  user    = aws_iam_user.my_iam.user_name
}

