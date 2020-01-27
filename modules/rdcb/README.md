# rdcb

<!-- BEGIN TFDOCS -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| S3Bucket | n/a | `any` | n/a | yes |
| StackName | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| AmiId | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| AmiNameSearchString | Search pattern to match against an AMI Name | `string` | `"Windows_Server-2016-English-Full-Base-*"` | no |
| CloudWatchAgentUrl | (Optional) HTTPS URL to CloudWatch Agent installer. Example: https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `""` | no |
| DataVolumeSize | Size of the data volume to attach to the instance | `string` | `"50"` | no |
| DataVolumeSnapshotId | (Optional) Snapshot ID of an existing EBS volume. Leave blank to instantiate an empty volume | `string` | `""` | no |
| DomainAccessUserGroup | Domain group of users authorized to use the remote access solution | `string` | `"yourgroupname"` | no |
| DomainDirectoryId | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | `string` | `"d-xxxxxxxxxx"` | no |
| DomainDnsName | Fully qualified domain name (FQDN) of the forest root domain, e.g. example.com | `string` | `"ad.example.com"` | no |
| DomainNetbiosName | NetBIOS name of the domain (e.g. EXAMPLE) | `string` | `"example"` | no |
| Ec2SubnetAz | Availability zone of the private subnet | `string` | `"us-east-1a"` | no |
| Ec2SubnetId | Private Subnet ID where the file server will run | `string` | `"subnet-xxxxxxxx"` | no |
| ExtraSecurityGroupIds | List of extra Security Group IDs to attach to the RDCB EC2 instance | `list(string)` | `[]` | no |
| ForceCfnInitUpdate | Toggles a cfn-init metadata update even if nothing else changes | `string` | `"A"` | no |
| InstanceType | Amazon EC2 instance type for the Remote Desktop Session Instance | `string` | `"t2.medium"` | no |
| KeyPairName | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `"yourkeypair"` | no |
| NoPublicIp | Controls whether to assign the instances a public IP. Recommended to leave at 'true' \_unless\_ launching in a public subnet | `string` | `"true"` | no |
| NotificationEmail | (Optional) Email address to subscribe to notifications and alarms | `string` | `""` | no |
| PatchSchedule | Schedule used to apply patches to the instance | `string` | `"cron(0 6 ? * Sat *)"` | no |
| PatchSnsTopicArn | SNS Topic used for patch status notifications | `string` | `""` | no |
| RdcbDnszoneId | Zone to create DNS record for RDCB instance | `string` | `""` | no |
| RepoBranchPrefixUrl | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/cfn/master"` | no |
| SecurityGroupIngress | List of security group IPs to allow | `list(string)` | `[]` | no |
| SnapshotFrequency | (Optional) Specify an interval in minutes to configure snapshots of the EBS fileshare volume. Set an empty value "" to skip configuring snapshots. Default interval is 60 minutes. | `string` | `"60"` | no |
| SsmKeyId | KMS Key ID used to encrypt/decrypt the SsmRdcbCredential | `string` | `"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"` | no |
| SsmRdcbCredential | SSM Parameter Name for a SecureString containing the domain credential for the RDCB service account. SSM Parameter Value format is '@{Username = "<user>"; Password = "<password>"}' | `string` | `"/your-path/rdcb/credential"` | no |
| TerminationProtection | Enable or disable instance termination protection.  Protection is enabled by default. | `string` | `true` | no |
| VpcId | VPC to deploy instance into | `string` | `"vpc-12345678"` | no |

## Outputs

| Name | Description |
|------|-------------|
| rdcb-dns-zone-id | n/a |
| rdcb-fqdn | n/a |
| rdcb-hostname | n/a |
| rdcb-instance-id | n/a |
| rdcb-instance-ip | n/a |
| rdcb-sg-id | n/a |
| rdcb-sns-arn | n/a |
| rdsh-sg-id | n/a |

<!-- END TFDOCS -->
