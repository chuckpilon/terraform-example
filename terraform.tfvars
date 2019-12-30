# Some IDEs will errorneously show errors in this file, such as "An argument named "aws_region" is not expected here."
# See https://github.com/mauve/vscode-terraform/issues/218 and https://github.com/juliosueiras/terraform-lsp/issues/39.

resource_prefix = "acme_proj1"
client_name     = "Acme Inc."
project_name    = "Project 1"

aws_region         = "us-east-2"
availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
aws_profile        = "default"

vpc_cidr_block = "172.30.0.0/16"

# TODO: Put these into an array.data
# Ideally, compute from vpc_cidr_block.
subnet1_cidr_block = "172.30.0.0/24"
subnet2_cidr_block = "172.30.1.0/24"
subnet3_cidr_block = "172.30.2.0/24"


rds_instance_name   = "acme-proj1"
rds_instance_class  = "db.t2.micro"
rds_master_username = "root"
rds_master_password = "megasecretpassword"
