resource "aws_codedeploy_app" "codedeploy_app" {
  compute_platform = "Server"
  name             = "example-codedeploy_app"
}

resource "aws_iam_role" "iam_role_codedeply" {
  name = "example-iam_role_codedeply"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.iam_role_codedeply.name
}

resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  app_name              = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name = "example-codedeploy_deployment_group"
  service_role_arn      = aws_iam_role.iam_role_codedeply.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "filterkey1"
      type  = "KEY_AND_VALUE"
      value = "filtervalue"
    }

    ec2_tag_filter {
      key   = "filterkey2"
      type  = "KEY_AND_VALUE"
      value = "filtervalue"
    }
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "example-trigger"
    trigger_target_arn = aws_sns_topic.example.arn
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}