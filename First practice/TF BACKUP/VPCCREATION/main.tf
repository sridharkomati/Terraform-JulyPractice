resource "aws_vpc" "ntier" {
  cidr_block = "var.ntier-vpc-range"
  tags = {
    Name = "ntier"
  }
}
resource "sub_net" "app1" {
  cidr_block = "var.aws_subnet_app1_cidr"
  tags = {
    Name = "app1"
  }
}
resource "sub_net" "app2" {
  cidr_block = "var.aws_subnet_app2_cidr"
  tags = {
    Name = "app2"
  }
}
resource "sub_net" "db1" {
  cidr_block = "var.aws_subnet_db1_cidr"
  tags = {
    Name = "db1"
  }
}
resource "sub_net" "db2" {
  cidr_block = "var.aws_subnet_db2_cidr"
  tags = {
    Name = "db2"
  }

}
