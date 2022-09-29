resource "aws_lb" "external-elb" {
  name               = "microservice-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secgru_microACV.id]
  subnets            = [aws_subnet.microsubnet_public.id, aws_subnet.microsubnet_public2.id]

  depends_on = [
    aws_instance.microserviceFront, aws_instance.microserviceFront2
  ]
}

resource "aws_lb_target_group" "external-elb" {
  name     = "ALB-TG"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.micro_vpc.id
}

resource "aws_lb_target_group_attachment" "external-elb1" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = aws_instance.microserviceFront.id
  port             = 8080

  depends_on = [
    aws_instance.microserviceFront
  ]
}
resource "aws_lb_target_group_attachment" "external-elb2" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = aws_instance.microserviceFront2.id
  port             = 8080

  depends_on = [
    aws_instance.microserviceFront2
  ]
}


resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external-elb.arn
  }
}