terraform {
    required_version = ">= 1.00"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.47.0"
    }
  }
}
provider "aws" {
    region = var.region

}