Terraform AWS Lambda Cron Job

This Terraform script automates the provisioning of an AWS Lambda function triggered by a cron job to execute every 5 minutes. Both the Lambda function code and the Terraform state will be stored in an S3 bucket.

Prerequisites

Before executing this Terraform script, ensure the following prerequisites are met:

AWS CLI: Ensure the AWS Command Line Interface (CLI) is installed on your system and configured with appropriate credentials. You can install and configure the AWS CLI by following the instructions provided in the AWS CLI documentation.
S3 Bucket Creation: Create an S3 bucket in your AWS account where the Lambda function code and Terraform state will be stored. Note down the name of the S3 bucket as it will be required as an input variable when executing the Terraform script.
Usage

Clone Repository: Clone this repository to your local machine or download the Terraform script file.
bash
Copy code
git clone <repository-url>
Navigate to Directory: Navigate to the directory containing the Terraform script.
bash
Copy code
cd terraform-aws-lambda-cron-job
Initialize Terraform: Initialize Terraform in the directory to download the necessary providers and modules.
bash
Copy code
terraform init
Provide Input Variables: Open the terraform.tfvars file and provide values for the required input variables. Ensure to set the lambda_tfstate_bucket variable to the name of the S3 bucket created in the prerequisites.
hcl
Copy code
lambda_tfstate_bucket = "your-s3-bucket-name"
region = "your-preferred-aws-region"
application_name = "your-lambda-function-name"
Review Terraform Plan: Optionally, review the Terraform plan to ensure correctness before applying changes.
bash
Copy code
terraform plan
Apply Terraform Changes: Apply the Terraform changes to create the Lambda function and associated resources.
bash
Copy code
terraform apply
Verify Resources: Once Terraform has successfully applied the changes, verify the creation of the Lambda function, CloudWatch Event Rule, and other associated resources in your AWS account.
Cleanup

To clean up and remove the resources provisioned by Terraform, execute the following steps:

Navigate to the directory containing the Terraform script.
bash
Copy code
cd terraform-aws-lambda-cron-job
Destroy Terraform Resources: Execute Terraform destroy to remove all the resources created by Terraform.
bash
Copy code
terraform destroy
Confirm Deletion: Confirm the deletion of resources by typing yes when prompted.
License

This project is licensed under the MIT License.

Feel free to adjust the instructions or add any additional details as needed for your specific setup and preferences. Let me know if you need further assistance!