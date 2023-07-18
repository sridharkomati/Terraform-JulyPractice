## creating vpc
resource "aws_vpc" "sri" {

  cidr_block = var.sri_vpc_info.vpc_cidr
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "sri_sub" {
  count             = length(var.sri_vpc_info.subnet_names)
  cidr_block        = cidrsubnet(var.sri_vpc_info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.sri_vpc_info.subnet_azs[count.index]}"
  vpc_id            = aws_vpc.sri.id

  tags = {
    Name = var.sri_vpc_info.subnet_names[count.index]

  }

}

resource "aws_internet_gateway" "sri_gt" {
  vpc_id = aws_vpc.sri.id
  tags = {
    Name = "mygateway"
  }

}
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = var.sri_vpc_info.public_subnets
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.sri.id]
  }
  depends_on = [
    aws_subnet.sri_sub
  ]

}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = var.sri_vpc_info.private_subnets
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.sri.id]
  }
  depends_on = [
    aws_subnet.sri_sub
  ]

}
data "aws_subnet" "web" {
  filter {
    name   = "tag:Name"
    values = [var.sri_vpc_info.ec2_subnet]
    ## dought    
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.sri.id]
  }
  depends_on = [
    aws_subnet.sri_sub
  ]

}



resource "aws_route_table" "sri_rt_public" {
  vpc_id = aws_vpc.sri.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sri_gt.id
  }
  tags = {
    Name = "public"
  }
  depends_on = [
    aws_subnet.sri_sub
  ]
}


resource "aws_route_table" "sri_rt_private" {
  vpc_id = aws_vpc.sri.id

  tags = {
    Name = "private"
  }
  depends_on = [
    aws_subnet.sri_sub
  ]
}



resource "aws_route_table_association" "public_association" {
  count          = length(var.sri_vpc_info.public_subnets)
  subnet_id      = data.aws_subnets.public.ids[count.index]
  route_table_id = aws_route_table.sri_rt_public.id
  depends_on = [
    aws_vpc.sri,
    aws_subnet.sri_sub
  ]

}

resource "aws_route_table_association" "private_association" {
  count          = length(var.sri_vpc_info.private_subnets)
  subnet_id      = data.aws_subnets.private.ids[count.index]
  route_table_id = aws_route_table.sri_rt_private.id
  depends_on = [
    aws_vpc.sri,
    aws_subnet.sri_sub
  ]

}



