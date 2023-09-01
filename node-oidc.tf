data "tls_certificate" "eks" {
    url = aws_eks_cluster.demoEksCluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eksOidc" {
  url = aws_eks_cluster.demoEksCluster.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
}