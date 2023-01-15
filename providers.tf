provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  
    docker = {
      source = "kreuzwerker/docker"
      version = "2.25.0"
    }
  }
}
