provider "aws" {
  region = "ap-southeast-1"
}

module "module_network" {
    source = "./network"
    vpc_name = "demo_vpc"
}

module "module_server"{
    source = "./server"
    public_subnet = module.module_network.public_subnet
    security_group = [module.module_network.security_group]
}

module "module_codeDeploy" {
    source = "./codeDeploy"
}

module "module_s3" {
    source = "./s3"
    bucket_name = "laravel-bucket123abc"
    aws_vpc_endpoint = module.module_network.vpc_id
}

terraform {
  backend "s3" {
      bucket = "terraform-state-dungdang"
      key = "terraform.tfstate"
    #   dynamodb_table = "terraform-state-locking"
      encrypt = true
  }
}
