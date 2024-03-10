

resource "aws_instance" "Netflix" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id[0]
  
 

  vpc_security_group_ids = var.default_security_group_ids
  user_data              = file("${path.module}/jenkins.sh")


  tags = {
    Name = "Netflix"
  }
}

#creating ssh-key
resource "aws_key_pair" "tf-key" {
  key_name   = var.key_name
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "demo-sg"

  }
}
