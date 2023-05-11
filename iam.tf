data "aws_iam_policy_document" "efs_csi_driver" {
  count = var.enabled ? 1 : 0

  statement {
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "ec2:DescribeAvailabilityZones"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "elasticfilesystem:CreateAccessPoint"
    ]
    resources = ["*"]
    effect    = "Allow"
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions = [
      "elasticfilesystem:TagResource"
    ]
    resources = ["*"]
    effect    = "Allow"
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    actions = [
      "elasticfilesystem:DeleteAccessPoint"
    ]
    resources = ["*"]
    effect    = "Allow"
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "efs_csi_driver" {
  depends_on  = [var.mod_dependency]
  count       = var.enabled ? 1 : 0
  name        = "${var.cluster_name}-efs-csi-driver"
  path        = "/"
  description = "Policy for the EFS CSI driver"

  policy = data.aws_iam_policy_document.efs_csi_driver[0].json
}

# Role
data "aws_iam_policy_document" "efs_csi_driver_assume" {
  count = var.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.cluster_identity_oidc_issuer_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_identity_oidc_issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}",
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "efs_csi_driver" {
  count              = var.enabled ? 1 : 0
  name               = "${var.cluster_name}-efs-csi-driver"
  assume_role_policy = data.aws_iam_policy_document.efs_csi_driver_assume[0].json
}

resource "aws_iam_role_policy_attachment" "efs_csi_driver" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.efs_csi_driver[0].name
  policy_arn = aws_iam_policy.efs_csi_driver[0].arn
}
