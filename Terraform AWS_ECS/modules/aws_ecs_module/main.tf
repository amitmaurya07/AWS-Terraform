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

resource "aws_iam_role" "three-tier-role" {
  name = "${var.name}-iam-role"
  assume_role_policy = jsonencode({
   "Version":"2012-10-17",
   "Statement":[
      {
         "Action":"sts:AssumeRole",
         "Effect":"Allow",
         "Principal":{
            "Service":[
               "ecs-tasks.amazonaws.com"
            ],
         },
      }
   ]
})

  tags = {
    "Name" = var.name
  }
}

resource "aws_iam_role_policy_attachment" "three-tier-policy" {
  role = aws_iam_role.three-tier-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "three-tier-definition" {
  family = "${var.name}-frontend"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 512
  memory = 1024
  execution_role_arn = aws_iam_role.three-tier-role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.name}-frontend"
      image     = "${var.ecr_repo_url}:${var.image_tag}"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 5173
          hostPort      = 5173
        },
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
  ])
}

resource "aws_ecs_service" "three-tier" {
  name            = "${var.name}-service"
  cluster         = aws_ecs_cluster.three-tier.id
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.three-tier-definition.arn
  desired_count   = 1
  network_configuration {
    subnets =  var.subnet_id
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
}