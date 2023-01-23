data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

data "template_file" "script" {
  template = file("userdata.sh")
  vars = {
    efs-id = aws_efs_file_system.this.id
    files = aws_efs_access_point.files.id
    upload = aws_efs_access_point.upload.id
    secret = aws_efs_access_point.secret.id
  }
}

resource "aws_instance" "teampass" {
  instance_type               = "t2.micro"
  ami                         = data.aws_ami.amazon.id
  user_data                   = data.template_file.script.rendered
  vpc_security_group_ids      = [aws_security_group.sg_ec2.id]
  subnet_id                   = aws_subnet.public01.id
  key_name                    = var.ec2_key_name
  associate_public_ip_address = true
  tags = {
    Name = "teampass"
  }
}