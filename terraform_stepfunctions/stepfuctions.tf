resource "aws_sfn_state_machine" "hoge-batch" {
  name     = "hoge-batch"
  role_arn = aws_iam_role.stepfunctions.arn
  type     = "EXPRESS"

  definition = data.template_file.student_update.rendered

  logging_configuration {
    log_destination        = "${aws_cloudwatch_log_group.statemachine_student_update.arn}:*"
    include_execution_data = true
    level                  = "ALL"
  }
}

data "template_file" "student_update" {
  template = file("${path.module}/stepfunctions_student_update.json")

  vars = {
    lambda_random_arn         = aws_lambda_function.random.arn
    lambda_student_update_arn = aws_lambda_function.student_update.arn
  }
}

resource "aws_cloudwatch_log_group" "statemachine_student_update" {
  name              = "/aws/vendedlogs/states/statemachine_hoge_batch-Logs"
  retention_in_days = 3
}
