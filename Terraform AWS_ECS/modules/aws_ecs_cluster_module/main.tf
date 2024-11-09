resource "aws_ecs_cluster" "three-tier" {
  name = var.name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    "Name" = var.name
  }
}