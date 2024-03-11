

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn


 vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.default_security_group_ids
    # security_group_ids = [aws_security_group.eks_cluster.id]
  }


 tags = {
    Environment = "Production"
  }
}

# creating nodegroup role
resource "aws_iam_role" "example" {
  name = "eks-node-group-example"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.example.name
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "example-workers"
  node_role_arn   = aws_iam_role.example.arn
  instance_types = ["t3.medium"]


 scaling_config {
    desired_size = 2 #var.desired_capacity
    min_size     = 2 #var.min_size
    max_size     = 2 #var.max_size
    
    
  }


 subnet_ids = var.subnet_ids


 depends_on = [aws_eks_cluster.cluster]
}



resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
 
 
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
 

resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_eks_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_ec2_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_ec2_container_registry_read_only_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# resource "aws_eks_node_group" "example" {
#   cluster_name    = aws_eks_cluster.cluster.name
#   node_group_name = "example-workers"
#   node_role_arn   = aws_iam_role.eks_node_role.arn


#  scaling_config {
#     desired_size = var.desired_capacity
#     min_size     = var.min_size
#     max_size     = var.max_size
#   }


#  subnet_ids = var.subnet_ids


#  depends_on = [aws_eks_cluster.cluster]
# }


