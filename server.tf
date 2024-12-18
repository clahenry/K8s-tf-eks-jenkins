# Fetch the latest Amazon Linux Image (AMI) owned by AWS
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.ami.image_id
  instance_type               = var.instance_type
  key_name                    = "demo"
  subnet_id                   = aws_subnet.jenkins-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.jenkins-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  user_data                   = file("jenkins-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }

}

output "avail_z" {
  value = var.availability_zone
}