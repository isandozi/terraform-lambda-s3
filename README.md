
# Terraform AWS Lambda Cron Job
This Terraform script automates the provisioning of an AWS Lambda function triggered by a cron job to execute every 5 minutes. Both the Lambda function code and the Terraform state will be stored in an S3 bucket.

Prerequisites

Before executing this Terraform script, ensure the following prerequisites are met:

AWS CLI: Ensure the AWS Command Line Interface (CLI) is installed on your system and configured with appropriate credentials. You can install and configure the AWS CLI by following the instructions provided in the AWS CLI [documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

S3 Bucket Creation: Create an S3 bucket in your AWS account. Note down the name of the S3 bucket as it will be required as an input variable when executing the Terraform script.
# Usage
Clone Repository: Clone this repository to your local machine or download the Terraform script file

`git clone <repository-url>`

Change directory into the repository

`cd terraform-lambda-s3`

Initialize Terraform: Initialize Terraform in the directory to download the necessary providers and modules.

`terraform init`

Provide Input Variables: Open the terraform.tfvars file and provide values for the required input variables. Ensure to set the lambda_tfstate_bucket variable to the name of the S3 bucket created in the prerequisites. The Terraform script will not execute until these values are provided.

`lambda_tfstate_bucket = "your-s3-bucket-name"`

`region = "your-preferred-aws-region"`

`application_name = "your-lambda-function-name"`

Review Terraform Plan: Optionally, review the Terraform plan to ensure correctness before applying changes.

`terraform plan`

Apply Terraform Changes: Apply the Terraform changes to create the Lambda function and associated resources.

`terraform apply`

Verify Resources: Once Terraform has successfully applied the changes, verify the creation of the Lambda function, CloudWatch Event Rule, and other associated resources in your AWS account.

# Cleanup
To clean up and remove the resources provisioned by Terraform, execute the following steps:

Navigate to the directory containing the Terraform script.

`cd terraform-lambda-s3`

Destroy Terraform Resources: Execute Terraform destroy to remove all the resources created by Terraform.

`terraform destroy`

Confirm Deletion: Confirm the deletion of resources by typing yes when prompted.