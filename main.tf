provider "aws" {
    region = var.region
}

terraform {
    required_version = ">= 1.0"

    backend "s3" {
        bucket = "uchicago-lambda-terraform-states"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}

resource "aws_iam_role" "uchicago_interview_poc" {
  name = "${var.application_name}-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "uchicago_interview_poc" {
  name        = "${var.application_name}-policy"
  description = "Policy for Lambda function to access S3 bucket"
  policy = data.aws_iam_policy_document.uchicago_interview_poc.json
}

data "aws_iam_policy_document" "uchicago_interview_poc" {
    statement {
        sid = "1"
        
        actions = [
            "logs:CreateLogGroup",
        ]
        
        resources = [
            "arn:aws:logs:${var.region}:*:*"
        ]
    }

    statement {
        sid = "2"
        
        actions = [
            "s3:GetObject",
            "s3:PutObject",
        ]
        
        resources = [
            "arn:aws:s3:::${var.lambda_tfstate_bucket}/*"
        ]
    }

    statement {
        sid = "3"
        
        actions = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ]
        
        resources = [
            "arn:aws:logs:${var.region}:*:log-group:*:*"
        ]
    }
}

resource "aws_iam_role_policy_attachment" "uchicago_interview_poc" {
  role       = aws_iam_role.uchicago_interview_poc.name
  policy_arn = aws_iam_policy.uchicago_interview_poc.arn
}

resource "aws_lambda_function" "uchicago_interview_poc" {
  function_name = var.application_name
  role = aws_iam_role.uchicago_interview_poc.arn
  s3_bucket = var.lambda_tfstate_bucket
  s3_key = "${var.application_name}.zip"
  handler = "${var.application_name}.lambda_handler"
  runtime = "python3.8"

  logging_config {
    log_format = "JSON"
    log_group = aws_cloudwatch_log_group.uchicago_interview_poc.name
  }
}

resource "aws_cloudwatch_event_rule" "uchicago_interview_poc" {
  name        = "${var.application_name}-5-minute-rule"
  description = "This rule executes the Lambda function every 5 minutes"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "uchicago_interview_poc" {
  target_id = aws_lambda_function.uchicago_interview_poc.function_name
  rule      = aws_cloudwatch_event_rule.uchicago_interview_poc.name
  arn       = aws_lambda_function.uchicago_interview_poc.arn
}

resource "aws_cloudwatch_log_group" "uchicago_interview_poc" {
  name = "${var.application_name}-log-group"

  tags = {
    Application = var.application_name
  }
}

# Lambda Permission to allow CloudWatch Event Rule to invoke Lambda
resource "aws_lambda_permission" "uchicago_interview_poc" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.uchicago_interview_poc.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.uchicago_interview_poc.arn
}

resource "aws_s3_object" "uchicago_interview_poc" {
  bucket = var.lambda_tfstate_bucket
  key    = "${var.application_name}.zip"
  source = "${path.module}/${var.application_name}.zip"
}