provider "aws" {
  region = "us-east-1"
}

# Define AWS RDS database resource
resource "aws_db_instance" "Main-instance" {
 identifier            = "main-db"
 allocated_storage     = 20
 storage_type          = "gp2"
 engine                = "mysql"
 engine_version        = "5.7"
 instance_class        = "db.t2.micro"
 username              = "himaja"
 password              = "AwsMain123"
 parameter_group_name  = "default.mysql5.7"
}

# Define AWS Lambda function
resource "aws_lambda_function" "db_query_lambda" {
  function_name    = "db_query_lambda"
  s3_bucket        = "himaja1-bucket"
  s3_key           = "path/to/your/lambda_function.zip"
  role             = aws_iam_role.lambda-access
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  timeout          = 60

  environment {
    variables = {
      db_host     = aws_db_instance.Main-instance.endpoint
      db_username = "himaja"
      db_password = "AwsMain123"
    }
  }
}

# Output the RDS database endpoint
output "db_endpoint" {
  value = aws_db_instance.Main-instance.endpoint
}
