variable "region" {
  type    = string
  default = "us-east-2"

}

variable "sri_vpc_info" {
  type = object({
    vpc_cidr        = string
    subnet_names    = list(string)
    public_subnets  = list(string)
    private_subnets = list(string)
    subnet_azs      = list(string)
    ec2_subnet      = string
  })
  default = {
    vpc_cidr        = "10.0.0.0/16"
    subnet_names    = ["web1", "web2", "app1", "app2", "db1", "db2"]
    public_subnets  = ["web1", "web2"]
    private_subnets = ["app1", "app2", "db1", "db2"]
    subnet_azs      = ["a", "b", "c", "a", "b", "c"]
    ec2_subnet      = "web2"
  }

}