# creating input variables for vpc
variable "aws_vpc_range" {
  type    = string
  default = "192.168.0.0/16"
}
# creating variablde for region
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
## variable for subnets
variable "aws_subnet_cidr" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24", "192.168.4.0/24", "192.168.5.0/24"]
}
## variable for subnets
variable "aws_subnet_azs" {
  type    = list(string)
  default = ["a", "b", "c", "a", "b", "c"]
}
## names for subnets
variable "aws_subnet_names" {
  type    = list(string)
  default = ["app1", "app2", "app3", "db1", "db2", "db3"]
}