resource "aws_instance" "bastion" {

  ami = "ami-0ff56409a6e8ea2a0"
  availability_zone = "ap-northeast-2a"
  instance_type = "t2.micro"
  key_name = "rapa"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  
  tags = {
      Name = "bastion"
  }
}
