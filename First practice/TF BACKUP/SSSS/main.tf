resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_range
  tags = {
    Name = "vpc"
  }
}
# creating subnet
resource "aws_subnet" "app1subnet" {
  count             = 5
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_cidr[count.index]
  availability_zone = "${var.aws_region}${var.aws_subnet_azs[count.index]}"
  depends_on = [
    aws_vpc.vpc
  ]
  tags = {
    Name = var.aws_subnet_names[count.index]
  }
}


