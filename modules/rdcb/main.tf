data "aws_cloudformation_stack" "this" {
  name       = var.StackName
  depends_on = [null_resource.push-changeset]
}

data "local_file" "rdcb_hostname" {
  filename   = "rdcb-hostname.txt"
  depends_on = [null_resource.get_ec2_hostname]
}

resource "aws_route53_record" "this" {
  zone_id    = var.RdcbDnszoneId
  name       = var.StackName
  type       = "A"
  ttl        = "300"
  records    = [data.aws_cloudformation_stack.this.outputs["RdcbEc2InstanceIp"]]
  depends_on = [data.aws_cloudformation_stack.this]
}

resource "aws_security_group" "rdcb-sg1" {
  name_prefix = "${var.StackName}-"
  description = "Security group for accessing rdcb"

  vpc_id = var.VpcId

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.SecurityGroupIngress
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.rdsh-sg1.id]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.StackName}-rdcb-sg1"
    Terraform = "True"
  }
}

resource "aws_security_group" "rdsh-sg1" {
  name_prefix = "${var.StackName}-"
  description = "Security group for accessing rdsh"

  vpc_id = var.VpcId

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.SecurityGroupIngress
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.StackName}-rdsh-sg1"
    Terraform = "True"
  }
}

resource "null_resource" "push-changeset" {
  provisioner "local-exec" {
    command     = join(" ", local.create_changeset_command)
    working_dir = path.module
  }

  provisioner "local-exec" {
    command = join(" ", local.destroy_changeset_command)
    when    = destroy
  }
}

resource "null_resource" "get_ec2_hostname" {
  provisioner "local-exec" {
    command = join(" ", local.get_ec2_hostname)
  }

  triggers = {
    instance_ids = join(",", null_resource.push-changeset.*.id)
  }
}

locals {
  create_changeset_command = [
    "aws cloudformation deploy --template",
    "ra_rdcb_fileserver_standalone.template.cfn.yaml",
    " --stack-name ${var.StackName}",
    " --s3-bucket ${var.S3Bucket}",
    " --parameter-overrides",
    "\"AmiId=${var.AmiId}\"",
    "\"AmiNameSearchString=${var.AmiNameSearchString}\"",
    "\"CloudWatchAgentUrl=${var.CloudWatchAgentUrl}\"",
    "\"DataVolumeSize=${var.DataVolumeSize}\"",
    "\"DataVolumeSnapshotid=${var.DataVolumeSnapshotId}\"",
    "\"DomainAccessUserGroup=${var.DomainAccessUserGroup}\"",
    "\"DomainDirectoryId=${var.DomainDirectoryId}\"",
    "\"DomainDnsName=${var.DomainDnsName}\"",
    "\"DomainNetbiosName=${var.DomainNetbiosName}\"",
    "\"Ec2SubnetAz=${var.Ec2SubnetAz}\"",
    "\"Ec2SubnetId=${var.Ec2SubnetId}\"",
    "\"ExtraSecurityGroupIds=${aws_security_group.rdcb-sg1.id},${join(",", var.ExtraSecurityGroupIds)}\"",
    "\"ForceCfnInitUpdate=${var.ForceCfnInitUpdate}\"",
    "\"InstanceType=${var.InstanceType}\"",
    "\"KeyPairName=${var.KeyPairName}\"",
    "\"NoPublicIp=${var.NoPublicIp}\"",
    "\"NotificationEmail=${var.NotificationEmail}\"",
    "\"PatchSchedule=${var.PatchSchedule}\"",
    "\"PatchSnsTopicArn=${var.PatchSnsTopicArn}\"",
    "\"RepoBranchPrefixUrl=${var.RepoBranchPrefixUrl}\"",
    "\"SnapshotFrequency=${var.SnapshotFrequency}\"",
    "\"SsmKeyId=${var.SsmKeyId}\"",
    "\"SsmRdcbCredential=${var.SsmRdcbCredential}\"",
    "\"TerminationProtection=${var.TerminationProtection}\"",
    "\"VpcId=${var.VpcId}\"",
    "--capabilities CAPABILITY_IAM",
  ]

  get_ec2_hostname = [
    "aws ec2 get-console-output --instance-id \"${data.aws_cloudformation_stack.this.outputs["RdcbEc2InstanceId"]}\"",
    " --output text | awk '/RDPCERTIFICATE-SUBJECTNAME: /{print $NF}' | sed 's/\r$//' | xargs echo -n > rdcb-hostname.txt",
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.StackName}",
  ]
}
