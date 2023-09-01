data "aws_iam_policy_document" "testOidcPolicy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eksOidc.url, "https://", "")}:sub"
      values   = ["system:serviceacount:default:aws-test"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eksOidc.arn]
      type        = "Federated"
    }
  }
}
resource "aws_iam_role" "test_oidc" {
  name               = "test_oidc"
  assume_role_policy = data.aws_iam_policy_document.testOidcPolicy.json
}

resource "aws_iam_policy" "test-policy" {
  name = "test-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "testOidc" {
  role       = aws_iam_role.test_oidc.name
  policy_arn = aws_iam_policy.test-policy.arn
}
output "test_policy_arn" {
  value = aws_iam_role.test_oidc.name
}