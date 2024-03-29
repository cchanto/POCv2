
resource "aws_alb" "alb" {
  name               = var.project_name
  internal           =    false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  security_groups    = [aws_security_group.alb.id]

  tags = {
    Name = var.project_name
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name        = var.project_name 
  port        = 8080   #targest groups
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  #vpc_id      = aws_vpc.vpc.id
  port              = 80 #loadblancer port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    type             = "forward"
  }
}

