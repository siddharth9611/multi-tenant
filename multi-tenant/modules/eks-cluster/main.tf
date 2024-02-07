#########--------------Variables------------##############

variable "cluster_name" {}
variable "cluster_subnet_id" {}


#######-----------------EKS-policy---------------########

data "aws_iam_policy" "eks_policy" {
    name = "AmazonEKSClusterPolicy"
}

##########---------------------IAM_ROLE-------------------#############



resource "aws_iam_role" "eks-role" {
  name = "project-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "eks_policy_attach" {
    name = "project-eks-policy"
    policy_arn = data.aws_iam_policy.eks_policy.arn
    roles = [aws_iam_role.eks-role.name]

}



############-----------------eks-cluster-----------------############
resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.cluster_name}-eks-cluster"
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    subnet_ids = [var.cluster_subnet_id]
  }

  # depends_on = [
  #   aws_iam_role_policy_attachment.eks_policy_attach
  # ]
}

############--------------outputs--------------#############

output "eks-cluster" {
  value = aws_eks_cluster.eks-cluster
}
