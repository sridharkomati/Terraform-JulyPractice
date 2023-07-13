provider "aws" {
  region = "us-east-1"

}

terraform {
  backend "s3" {
    bucket = "sss006"
    key    = "backend/state1"
    region = "us-east-1"
    dynamodb_table = "qtsridb"
  }
}
