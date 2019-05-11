data "aws_vpc" "selected" {
  default = true
}

data "aws_subnet_ids" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
}

resource "aws_iam_role" "ec2-node" {
  name = "asg-web"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2-node" {
  name = "ec2-node"
  role = "${aws_iam_role.ec2-node.name}"
}

resource "aws_security_group" "ec2-node" {
  name        = "ec2-node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${data.aws_vpc.selected.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ec2-node-ingress-http" {
  description              = "Allow port 80"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.ec2-node.id}"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2-node-ingress-ssh" {
  description              = "Allow port ssh"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.ec2-node.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2-node-ingress-https" {
  description              = "Allow port 443"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.ec2-node.id}"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = "${var.ssh_key}"
}


resource "aws_launch_configuration" "ec2-node" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.ec2-node.name}"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  name_prefix                 = "asg-web"
  security_groups             = ["${aws_security_group.ec2-node.id}"]
  user_data_base64            = "${base64encode(file("${path.module}/scripts/install-web.sh"))}"
  key_name                    = "${aws_key_pair.ssh_key.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ec2_nodes" {
  desired_capacity     = "${var.desired_capacity}"
  launch_configuration = "${aws_launch_configuration.ec2-node.id}"
  max_size             = "${var.max_capacity}"
  min_size             = "${var.min_capacity}"
  name                 = "web-asg"
  vpc_zone_identifier  = ["${data.aws_subnet_ids.selected.ids}"]
}