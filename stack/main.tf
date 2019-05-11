provider "aws" {
  region = "us-east-1"
}

module "asg-web" {
  source = "../modules/asg-web"
  ami = "${var.ami_web}"
  instance_type = "${var.instance_type_web}"
  ssh_key = "${var.ssh_key}"
  desired_capacity = "3"
  min_capacity = "3"
  max_capacity = "3"
}