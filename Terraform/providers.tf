terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }

}
provider "aws" {
  access_key = var.aws_cred.accessskey
  secret_key = var.aws_cred.secreatkey
  region     = var.aws_cred.region

}
