data "aws_availability_zones" "available" {
}

resource "aws_lb" "three-tier" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_id

  enable_deletion_protection = false

  tags = {
    "Name" = var.name
  }
}

resource "aws_lb_target_group" "ip-frontend" {
  name        = "${var.name}-frontend-tg"
  port        = 5173
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    protocol              = "TCP"
    port                  = "traffic-port"
    healthy_threshold     = 2
    unhealthy_threshold   = 2
    timeout               = 10
    interval              = 30
  }
}

resource "aws_lb_target_group" "ip-backend" {
  name        = "${var.name}-backend-tg"
  port        = 5000
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    protocol              = "TCP"
    port                  = "traffic-port"
    healthy_threshold     = 2
    unhealthy_threshold   = 2
    timeout               = 10
    interval              = 30
  }
}

resource "aws_lb_listener" "three-tier-listen-frontend" {
  load_balancer_arn = aws_lb.three-tier.arn
  port              = 5173
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip-frontend.arn
  }
}

resource "aws_lb_listener" "three-tier-listen-backend" {
  load_balancer_arn = aws_lb.three-tier.arn
  port              = 5000
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip-backend.arn
  }
}