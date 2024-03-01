resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.lambda-access
  policy_arn = aws_iam_policy.lambda-s3-access
}
resource "aws_iam_policy" "example_policy" {
  name        = "lambda-s3-access"
  description = "An example IAM policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
        ]
        Resource = [
          "arn:aws:s3:::example-bucket/*",
        ]
      },
    ]
  })
}
resource "aws_iam_role" "example_role" {
  name               = "lambda-access"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      },
    ]
  })
}
