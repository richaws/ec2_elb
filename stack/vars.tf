variable "ami_web" {
  type = "string"
  description = "AMI for Web"
  default = "ami-0de53d8956e8dcf80"
}

variable "ssh_key" {
  type = "string"
  description = "SSH Public Key"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4EQsnCjcG9DTrr5yG5ZiNSO2POdiknSphvvh+8pxdfADRlxg5fS3z4Q8CfuYdGqOXSoH4xWEpWOJVKEbFSsfM278MeyRnS7g1aUVT1VMWEPOtpmfBwN9FqMVctlHN8OdzGSY/31tuuTILtkPJ5pAFrPougpvECrJdd25WP/Z8KdpZecdccUPGJdh2etfjPOCScv3FxoGMgeZUenuhkLTsKbvHopGUpwIlLfVn6Ke+OOZheg4rk2fCaCh6pK9Y83jMasbyqkNsRI+ag3jhJBXOQ1WkSVR6HyItWPo1/JZevGP00Iqmrey7Pq/9JkE0SHWy0PBg5K5LyOvBsEzLtOuN richaws"
}

variable "instance_type_web" {
  type = "string"
  description = "Web Instance Type"
  default = "t2.micro"
}