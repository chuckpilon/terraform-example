# Terraform Example

## Environment Setup

You can use the Vagrant virtual machine located in the `vagrant` directory or install the required tools natively.

### Vagrant Virtual Machine

Unless otherwise specified, all paths are relative to the project's root.

1. Install Vagrant (https://www.vagrantup.com/docs/installation)
1. Install VirtualBox (https://www.virtualbox.org/manual/ch02.html and https://www.virtualbox.org/wiki/Downloads)
1. Install the `vagrant-vbguest` plugin:

  		$ vagrant plugin install vagrant-vbguest

1. Make sure `~/.aws/credentials` and `~/.aws/config` exist and are correct. These files can be created by installing the AWS CLI then running `aws configure` or by manually creating the files. See https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html and https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html.
1. Copy `vagrant/config.example.yaml` to `vagrant/config.yaml` and update the settings. See inline comments for instructions.
1. Start and provision the vagrant environment:

		$ cd vagrant
		$ vagrant up
		...
		default: Installed packages:
		default: Terraform v0.12.18
		default: aws-cli/1.16.310 Python/2.7.5 Linux/3.10.0-957.12.2.el7.x86_64 botocore/1.13.46

### Native

1. Install terraform

   See https://learn.hashicorp.com/terraform/getting-started/install

1. Initialize

	Initialize various local settings and data that will be used by subsequent commands.

		$ terraform init

## Building

### Vagrant

1. ssh into the Vagrant VM and cd to the `terraform` directory :

		$ cd vagrant
		$ vagrant ssh
		$ cd <project-root>/terraform

1. Copy `terraform.example.tfvars` to `terraform.tfvars`.
1. Update `terraform.tfvars` and set the variables to the desired values.
1. Run terraform

		$ terraform apply

### Native

1. cd to the `terraform` directory and initialize Terraform:

		$ cd terraform
		$ terraform init

1. Copy `terraform.example.tfvars` to `terraform.tfvars`.
1. Update `terraform.tfvars` and set the variables to the desired values.
1. Run terraform

		$ terraform apply
	
## Destroying	

	$ cd terraform
	$ terraform destroy
