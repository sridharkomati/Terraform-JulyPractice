resource "aws_vpc" "sri" {
  cidr_block = var.sri_vpc_info.vpc_cidr
  tags = {
    Name = "sri"
  }
}

# creating subnet
resource "aws_subnet" "sss" {
  count             = length(var.sri_vpc_info.subnet_names)
  vpc_id            = aws_vpc.sri.id
  cidr_block        = cidrsubnet(var.sri_vpc_info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.sri_vpc_info.subnet_azs[count.index]}"
  tags = {
    Name = var.sri_vpc_info.subnet_names[count.index]
  }
  depends_on = [
    aws_vpc.sri
  ]
}
