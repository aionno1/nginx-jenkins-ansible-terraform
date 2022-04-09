terraform {
  required_version = "0.12.20"
}

provider "aws" {
    region=var.region
    profile=var.profile
}

resource "aws_instance" "site" {
    ami = "ami-042e8287309f5df03"
    instance_type="t2.micro"
    key_name="devops_01_ssh"
    vpc_security_group_ids = ["sg-afcba9d5","sg-01e0c5a49c8b5e4ae"]
        tags = {
            Name = var.name
            group = var.group
        }
}