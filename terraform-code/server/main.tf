resource "aws_instance" "web_instance" {
  ami           = var.ami
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  key_name = var.key_name
  subnet_id = element(var.public_subnet,0)
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id
  vpc_security_group_ids = var.security_group
  user_data = filebase64("${path.module}/bash.sh")
  tags = {
    Name = "web_instance"
  }
}

resource "aws_iam_policy" "iam_policy" {
  name        = "test_policy123"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "iam_role" {
  name = "test_role123"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile123"
  role = aws_iam_role.iam_role.name
}
