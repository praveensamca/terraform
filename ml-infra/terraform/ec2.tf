resource "aws_instance" "example1" {
  ami           = data.aws_ami.amazon.id # Change to your desired AMI ID
  instance_type = "t2.micro"               # Change to your desired instance type
  key_name      = aws_key_pair.deployer.id
  associate_public_ip_address  = true
  subnet_id = aws_subnet.main1.id
  user_data = file("./script.sh")
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "ExampleInstance_from_main_1"               # Change to your desired instance name

  }
  provisioner "file" {
    source      = "./sam.py"
    destination = "/tmp/sam.py"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/praveen.sambath/.ssh/id_rsa")
      host        = "${self.public_dns}"
    }
  }
}

output "ec2_global_ips_1" {
  value = aws_instance.example1.public_ip
}
####
resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon.id # Change to your desired AMI ID
  instance_type = "t2.micro"               # Change to your desired instance type
  key_name      = aws_key_pair.deployer.id
  associate_public_ip_address  = true
  subnet_id = aws_subnet.main.id
  user_data = file("./script.sh")
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "ExampleInstance"               # Change to your desired instance name

  }
  provisioner "file" {
    source      = "./sam.py"
    destination = "/tmp/sam.py"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/praveen.sambath/.ssh/id_rsa")
      host        = "${self.public_dns}"
    }
  }
}

output "ec2_global_ips" {
  value = aws_instance.example.public_ip
}
