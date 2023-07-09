resource "aws_vpc" "sri" {
  cidr_block = var.sri_vpc_info.vpc_cidr

  tags = {
    Name = "sri"
  }
}

resource "aws_subnet" "sss" {
  vpc_id            = local.vpc_id
  count             = length(var.sri_vpc_info.subnet_names)
  cidr_block        = cidrsubnet(var.sri_vpc_info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.sri_vpc_info.subnet_azs[count.index]}"

  tags = {
    Name = var.sri_vpc_info.subnet_names[count.index]
  }
  depends_on = [
    aws_vpc.sri
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "sri-igw"
  }
}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id
  tags = {
    Name = "private"
  }
  depends_on = [
    aws_subnet.sss
  ]
}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  tags = {
    Name = "public"
  }

  route  {
    cidr_block = local.anywhre
    gateway_id = aws_internet_gateway.igw.id
  }
  depends_on = [
    aws_subnet.sss
  ]
}

