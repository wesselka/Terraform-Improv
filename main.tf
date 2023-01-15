data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

/* resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"
  #key_name = "id_rsa.pub"
  public_key = file(var.public_key_location)
} */

resource "aws_instance" "test-server" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.test-subnet-1.id
  vpc_security_group_ids = [aws_security_group.test-sg.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true
  #key_name = aws_key_pair.ssh-key.key_name
  
  user_data = file("entry-script.sh")

 tags = {
   Name = "${var.env_prefix}-server"
 }
}
