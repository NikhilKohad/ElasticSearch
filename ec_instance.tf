
# Define Elastic search server inside the public subnet
resource "aws_instance" "ES" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "DevOps_Keys"
  //key_name = aws_key_pair.default.id
  subnet_id                   = aws_subnet.pub_subnet.id
  vpc_security_group_ids      = ["${aws_security_group.es-sec-grp.id}"]
  associate_public_ip_address = true
  source_dest_check           = false
  
  tags = {
    Name = "Elastic-Search"
  }
}