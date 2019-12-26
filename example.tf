provider "aws" {
  version = "~> 2.43"
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
