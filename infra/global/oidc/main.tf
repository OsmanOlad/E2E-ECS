resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-ecs-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub": "repo:OsmanOlad/E2E-ECS:*"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy" "github_actions_policy" {
  name = "github-actions-deploy-policy"
  role = aws_iam_role.github_actions_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
  
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {

        Action = [
          "ec2:*",
          "ecs:*",
          "elasticloadbalancing:*",
          "iam:*",
          "logs:*",
          "ecr:*",
          "application-autoscaling:*",
          "codedeploy:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
