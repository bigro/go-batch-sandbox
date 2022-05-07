# 作成したECRリポジトリのURIを設定する
variable "image-uri" {
  default = ""
}

# タスク定義
resource "aws_ecs_task_definition" "hoge-task" {
  family                   = "hoge-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = templatefile(
    "./hoge_container_definitions.json",
    {
      image = var.image-uri
    }
  )
}

# ECSクラスター
resource "aws_ecs_cluster" "batch-cluster" {
  name = "batch-cluster"
}
