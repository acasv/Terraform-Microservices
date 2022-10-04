resource "aws_security_group" "secgru_microACV" {
  name        = "secgru_microACV"
  description = "Security group for microservices and ssh connection"
  vpc_id = aws_vpc.micro_vpc.id

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 8080
    protocol    = "TCP"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 8000
    protocol    = "TCP"
    to_port     = 8000
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9411
    protocol    = "TCP"
    to_port     = 9411
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 8082
    protocol    = "TCP"
    to_port     = 8082
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6379
    protocol    = "TCP"
    to_port     = 6379
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 8083
    protocol    = "TCP"
    to_port     = 8083
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8090
    protocol    = "TCP"
    to_port     = 8090
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1" # open all out rule
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    Name = "Microservices SG",
    project     = "andres.castrillonv-rampup",
    responsible = "andres.castrillonv"
  }
}