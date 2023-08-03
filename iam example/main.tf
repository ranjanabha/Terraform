provider "aws"{
    region="eu-west-2"
}

resource "aws_iam_user" "user" {
  name="RJ"
}

resource "aws_iam_policy" "my_policy" {
  name="userpolicy"
  policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"elasticfilesystem:DeleteAccessPoint",
				"elasticfilesystem:DescribeReplicationConfigurations",
				"glacier:AbortMultipartUpload",
				"elasticfilesystem:PutAccountPreferences",
				"elasticfilesystem:CreateFileSystem",
				"elasticfilesystem:DeleteReplicationConfiguration",
				"glacier:CreateVault",
				"elasticfilesystem:DescribeAccountPreferences",
				"elasticfilesystem:ClientWrite",
				"glacier:ListParts",
				"elasticfilesystem:CreateReplicationConfiguration",
				"glacier:DeleteVaultNotifications",
				"glacier:ListJobs",
				"glacier:InitiateMultipartUpload",
				"elasticfilesystem:PutLifecycleConfiguration",
				"glacier:PurchaseProvisionedCapacity",
				"elasticfilesystem:DescribeFileSystems",
				"elasticfilesystem:DeleteMountTarget",
				"glacier:UploadArchive",
				"elasticfilesystem:CreateAccessPoint",
				"elasticfilesystem:ModifyMountTargetSecurityGroups",
				"glacier:InitiateJob",
				"elasticfilesystem:Restore",
				"glacier:ListTagsForVault",
				"glacier:DeleteVault",
				"glacier:DeleteArchive",
				"elasticfilesystem:DescribeAccessPoints",
				"elasticfilesystem:CreateMountTarget",
				"glacier:ListMultipartUploads",
				"glacier:SetVaultNotifications",
				"glacier:CompleteMultipartUpload",
				"ec2:*",
				"elasticfilesystem:Backup",
				"elasticfilesystem:PutBackupPolicy",
				"glacier:UploadMultipartPart",
				"elasticfilesystem:ClientRootAccess",
				"glacier:ListVaults",
				"elasticfilesystem:DeleteFileSystem",
				"glacier:ListProvisionedCapacity",
				"elasticfilesystem:UpdateFileSystem"
			],
			"Resource": "*"
		}
	]
    })
  
}

resource "aws_iam_policy_attachment" "policyAttachment" {
  name="policyAttachment"
  users=[aws_iam_user.user.name]
  policy_arn = aws_iam_policy.my_policy.arn
}
