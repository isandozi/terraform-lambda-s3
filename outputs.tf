output "lambda_function_arn" {
  value = aws_lambda_function.interview_poc.arn
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.interview_poc.arn
}

output "s3_bucket_name" {
  value = var.lambda_tfstate_bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.interview_poc.function_name
}

output "iam_role_arn" {
  value = aws_iam_role.interview_poc.arn
}
