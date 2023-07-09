variable "aws-region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region"
}

variable "instance-ami" {
  type        = string
  default     = "ami-007855ac798b5175e"
  description = "Instance AMI id"
}

variable "instance-type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "instance-associate-public-ip" {
  type        = string
  default     = "true"
  description = "EC2 instance public IP address."
}

variable "vpc-cidr-block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block to associate to the VPC"
}

variable "subnet-cidr-block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The CIDR block to associate to the subnet"
}
