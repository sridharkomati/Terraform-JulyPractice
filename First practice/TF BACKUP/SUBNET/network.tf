resource "aws_vpc" "vpc1" {
  cidr_block = var.aws_vpc_range
  tags = {
    Name = "vpc1"
  }
}
# creating subnet
resource "aws_subnet" "app1" {
  vpc_id            =     aws_vpc.vpc1.id
  cidr_block        = var.aws_subnet_app1_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "app1"
  }
  
}
resource "aws_subnet" "app2" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.aws_subnet_app2_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    "Name" = "app2"
  }
}
resource "aws_subnet" "app3" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.aws_subnet_app3_cidr
  availability_zone = "${var.aws_region}c"
  tags = {
    "Name" = "app3"
  }
}
resource "aws_subnet" "db1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.aws_subnet_db1_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    "Name" = "db1"
  }
}
resource "aws_subnet" "db2" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.aws_subnet_db2_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    "Name" = "db2"
  }
}
resource "aws_subnet" "db3" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.aws_subnet_db3_cidr
  availability_zone = "${var.aws_region}c"
  tags = {
    "Name" = "db3"
  }
}