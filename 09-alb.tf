resource "aws_lb" "this" {
  load_balancer_type = "application"
  name               = "${var.project-name}-alb"
  security_groups    = [aws_security_group.sg_alb.id]
  subnets            = [aws_subnet.public01.id, aws_subnet.public02.id, aws_subnet.public03.id]
  tags = {
    "Name" = "${var.project-name}-alb"
  }
}


resource "aws_lb_target_group" "this" {
  name     = "${var.project-name}-tg"
  port     = 80
  protocol = "HTTP"

  tags = {
    "Name" = "${var.project-name}-tg"
  }

  target_type = "instance"
  vpc_id      = aws_vpc.this.id

  health_check {
    healthy_threshold = 2
    path              = "/"
    matcher             = "200,301,302"
  }

  stickiness {
    cookie_duration = 3600
    enabled         = true
    type            = "lb_cookie"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}