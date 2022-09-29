resource "aws_instance" "microserviceBack" {
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykeypair.id
  user_data = file("../infra/backend.sh")

  security_groups = [ aws_security_group.secgru_microACV.id ]
  subnet_id = aws_subnet.microsubnet_private.id

  private_ip = "10.0.1.10"

  depends_on = [aws_subnet.microsubnet_private]

  tags = { 
    Name = "microserviceBack",
    project     = "andres.castrillonv-rampup",
    responsible = "andres.castrillonv"}
  volume_tags = {
    Name        = "microserviceBack"
    project     = "andres.castrillonv-rampup"
    responsible = "andres.castrillonv"}
}

resource "aws_instance" "microserviceFront" {
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykeypair.id
  user_data = file("../infra/frontend.sh")

  private_ip = "10.0.2.10"

  associate_public_ip_address = true

  security_groups = [ aws_security_group.secgru_microACV.id]
  subnet_id = aws_subnet.microsubnet_public.id

  depends_on = [aws_subnet.microsubnet_public, aws_instance.microserviceBack]

  tags = { 
    Name = "microserviceFront",
    project     = "andres.castrillonv-rampup",
    responsible = "andres.castrillonv"}
  volume_tags = {
    Name        = "microserviceFront"
    project     = "andres.castrillonv-rampup"
    responsible = "andres.castrillonv"}
}

resource "aws_instance" "microserviceFront2" {
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykeypair.id
  user_data = file("../infra/frontend.sh")

  private_ip = "10.0.3.10"

  associate_public_ip_address = true

  security_groups = [ aws_security_group.secgru_microACV.id]
  subnet_id = aws_subnet.microsubnet_public2.id

  depends_on = [aws_subnet.microsubnet_public2, aws_instance.microserviceBack]

  tags = { 
    Name = "microserviceFront2",
    project     = "andres.castrillonv-rampup",
    responsible = "andres.castrillonv"}
  volume_tags = {
    Name        = "microserviceFront"
    project     = "andres.castrillonv-rampup"
    responsible = "andres.castrillonv"}
}