data "aws_cloudformation_stack" "this" {
  name       = var.StackName
  depends_on = [null_resource.push-changeset]
}

data "aws_lb" "this" {
  arn        = data.aws_cloudformation_stack.this.outputs["LoadBalancerName"]
  depends_on = [data.aws_cloudformation_stack.this]
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

locals {
  create_changeset_command = [
    "aws cloudformation deploy --template",
    "ra_rdgw_autoscale_public_lb.template.cfn.yaml",
    " --stack-name ${var.StackName}",
    " --s3-bucket ${var.S3Bucket}",
    " --parameter-overrides AmiId=${var.AmiId}",
    "\"AmiNameSearchString=${var.AmiNameSearchString}\"",
    "\"AuthenticationMethod=${var.AuthenticationMethod}\"",
    "\"CloudWatchAgentUrl=${var.CloudWatchAgentUrl}\"",
    "\"DesiredCapacity=${var.DesiredCapacity}\"",
    "\"DomainDirectoryId=${var.DomainDirectoryId}\"",
    "\"DomainDnsName=${var.DomainDnsName}\"",
    "\"DomainNetbiosName=${var.DomainNetbiosName}\"",
    "\"ForceUpdateToggle=${var.ForceUpdateToggle}\"",
    "\"InstanceType=${var.InstanceType}\"",
    "\"KeyPairName=${var.KeyPairName}\"",
    "\"MaxCapacity=${var.MaxCapacity}\"",
    "\"MinCapacity=${var.MinCapacity}\"",
    "\"PrivateSubnetIDs=${join(",", var.PrivateSubnetIds)}\"",
    "\"PublicSubnetIDs=${join(",", var.PublicSubnetIds)}\"",
    "\"RemoteAccessUserGroup=${var.RemoteAccessUserGroup}\"",
    "\"RepoBranchPrefixUrl=${var.RepoBranchPrefixUrl}\"",
    "\"ScaleDownDesiredCapacity=${var.ScaleDownDesiredCapacity}\"",
    "\"ScaleDownSchedule=${var.ScaleDownSchedule}\"",
    "\"ScaleUpSchedule=${var.ScaleUpSchedule}\"",
    "\"SslCertificateName=${var.SslCertificateName}\"",
    "\"SslCertificateService=${var.SslCertificateService}\"",
    "\"UpdateSchedule=${var.UpdateSchedule}\"",
    "\"VPC=${var.VpcId}\"",
    "--capabilities CAPABILITY_IAM",
  ]

  check_stack_progress = [
    "aws cloudformation wait stack-create-complete --stack-name ${var.StackName}",
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.StackName}",
  ]
}

resource "aws_route53_record" "this" {
  zone_id = var.PublicDnszoneId
  name    = var.DnsName
  type    = "A"

  alias {
    name                   = data.aws_lb.this.dns_name
    zone_id                = data.aws_lb.this.zone_id
    evaluate_target_health = true
  }
  # depends_on = [data.aws_lb.this]

}

