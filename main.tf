# This stack assumes that a Default VPC is present

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "test-lc" {
  name_prefix = "test-lc-"
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"

  key_name = "${var.key_name}"
  security_groups = [ "${aws_security_group.instance.id}" ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "test-asg" {
  name = "test-asg"
  min_size = 1
  max_size = 1
  launch_configuration = "${aws_launch_configuration.test-lc.id}"
  availability_zones = ["${var.region}a"]
}

resource "aws_security_group" "instance" {
  name = "test-sg"
  description = "Allow traffic for test-asg instances"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
