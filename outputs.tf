output "lambda_function_arn" {
  value = aws_lambda_function.uchicago_interview_poc.arn
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.uchicago_interview_poc.arn
}

output "s3_bucket_name" {
  value = var.lambda_tfstate_bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.uchicago_interview_poc.function_name
}

output "iam_role_arn" {
  value = aws_iam_role.uchicago_interview_poc.arn
}
