# Create a Lambda function
/*
resource "aws_lambda_function" "comprehend_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "ComprehendLambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec.arn
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_exec" {
  name        = "lambda_exec"
  description = "Execution role for Lambda function"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policies to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/ComprehendReadOnly"
}

# Update the Lex bot to use the Lambda function
resource "aws_lex_bot" "film_bot" {
  name    = "FilmBot"
  version = "1"

  # ... other properties ...

  dialog_code_hook {
    uri                   = aws_lambda_function.comprehend_lambda.invoke_arn
    message_version       = "1.0"
  }
}
*/