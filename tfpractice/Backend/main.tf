resource "aws_vpc" "rrr" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_subnet" "mysubnet" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.rrr.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "mysbn"
  }

}

