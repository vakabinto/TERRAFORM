resource "aws_iam_role" "demoRole" {
  name = "eks-cluster-demo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com",
        },
      },
    ],
  })
}
resource "aws_iam_role_policy_attachment" "demoEKSclusterPolicy" {
  role       = aws_iam_role.demoRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "demoEksCluster" {
  name     = "demo"
  role_arn = aws_iam_role.demoRole.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.mysubPub1.id,
      aws_subnet.mysubPub2.id,
      aws_subnet.mysubPriv1.id,
      aws_subnet.mysubPriv2.id 

    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.demoEKSclusterPolicy
  ]
}
