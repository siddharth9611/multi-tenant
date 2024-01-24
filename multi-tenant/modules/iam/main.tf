variable "name" {}
variable "policy_arn" {}






resource "aws_iam_role" "eks-role" {
    name = var.name
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
    name = var.name
    policy_arn = var.policy_arn
}