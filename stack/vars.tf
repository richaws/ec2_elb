variable "ami_web" {
  type = "string"
  description = "AMI for Web"
  default = "ami-0de53d8956e8dcf80"
}

variable "ssh_key" {
  type = "string"
  description = "SSH Public Key"
  default = "ssh-rsa  richaws"
}

variable "instance_type_web" {
  type = "string"
  description = "Web Instance Type"
  default = "t2.micro"
}
