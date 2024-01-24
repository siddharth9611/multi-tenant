data "aws_iam_policy" "eks_policy" {
    name = "AmazonEKSClusterPolicy"
    
}

resource "aws_iam_role" "eks-role" {
    name = "eks-role"
    assume_role_policy ={
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "eks.amazonaws.com"
                }
                "Action": "sts:AssumeRole"
            }
        ]
            
    }
}

resource "aws_iam_policy_attachment" "eks_policy_attach" {
    name = "eks policy"
    policy_arn = data.aws_iam_policy.eks_policy.arn
}