resource "aws_iam_role" "stepfunctions" {
  name               = "MyStepFunctionsRole"
  assume_role_policy = data.aws_iam_policy_document.stepfunctions_assume.json
}

data "aws_iam_policy_document" "stepfunctions_assume" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "states.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role_policy" "stepfunctions_custom" {
  role   = aws_iam_role.stepfunctions.id
  name   = "BatchStepFunctionsPolicy"
  policy = data.aws_iam_policy_document.stepfunctions_custom.json
}

variable "hoge-task-arn" {
  default = ""
}

data "aws_iam_policy_document" "stepfunctions_custom" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogDelivery",
      "logs:GetLogDelivery",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:ListLogDeliveries",
      "logs:PutResourcePolicy",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
    ]

    resources = [
      var.hoge-task-arn,
    ]
  }
}
