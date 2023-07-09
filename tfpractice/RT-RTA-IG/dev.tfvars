region = "us-east-1"

sri_vpc_info = {
  vpc_cidr        = "10.0.0.0/16"
  subnet_names    = ["web1", "web2", "app1", "app2", "db1", "db2"]
  public_subnets  = ["web1", "web2"]
  private_subnets = ["app1", "app2", "db1", "db2"]
  subnet_azs      = ["a", "b", "a", "b", "a", "b"]
  ec2_subnet      = "web2"
}
