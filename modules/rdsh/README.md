# rdsh

<!-- BEGIN TFDOCS -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| DomainSvcAccount | User name for the account that will join the instance to the Connection Broker Cluster | `string` | n/a | yes |
| DomainSvcPassword | Password for the Connection Broker service account. Must be at least 8 characters containing letters, numbers and symbols | `string` | n/a | yes |
| RdpPrivateKeyPassword | Password to the RDP certificate private key | `string` | n/a | yes |
| RdpPrivateKeyPfx | S3 bucket and path to a private key for the RDP certificate, e.g. '<bucket>/path/to/key.pfx' | `string` | n/a | yes |
| StackName | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| VpcId | VPC to deploy instance(s) into | `string` | n/a | yes |
| AmiId | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| AmiNameSearchString | Search pattern to match against an AMI Name | `string` | `"Windows_Server-2016-English-Full-Base-*"` | no |
| CloudWatchAgentUrl | (Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `""` | no |
| ConnectionBrokerFqdn | Fully qualified domain name (FQDN) of the primary Connection Broker, e.g. 'cb.example.com' | `string` | `""` | no |
| DesiredCapacity | The number of instances the autoscale group will spin up initially | `string` | `"1"` | no |
| DnsName | Name of Host A DNS Record | `string` | `""` | no |
| DomainAccessUserGroup | Domain group of users authorized to use the RDSH | `string` | `"Domain Users"` | no |
| DomainDirectoryId | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | `string` | `""` | no |
| DomainDnsName | Fully qualified domain name (FQDN) of the forest root domain e.g. example.com | `string` | `"example.com"` | no |
| DomainNetbiosName | Netbios name of the domain (e.g. EXAMPLE) | `string` | `"EXAMPLE"` | no |
| ExtraSecurityGroupIds | Comma separated string of extra Security Group IDs to attach to the RDSH instances -- include \_at least\_ the SG allowing connectivity to the Connection Broker database | `list(string)` | `[]` | no |
| ForceUpdateToggle | A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy | `string` | `"A"` | no |
| InstanceType | Amazon EC2 instance type for the Remote Desktop Session Instance | `string` | `"t2.medium"` | no |
| KeyPairName | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `""` | no |
| LdapContainerOU | DN of the LDAP container or OU in which the RDSH instance will be placed | `string` | `"OU=Users,DC=example,DC=com"` | no |
| MaxCapacity | The maximum number of instances for the autoscale group | `string` | `"2"` | no |
| MinCapacity | The minimum number of instances for the autoscale group | `string` | `"0"` | no |
| NlbZones | Map of NLB Zones | `map(string)` | <pre>{<br>  "us-east-1": "Z26RNL4JYFTOTI",<br>  "us-east-2": "ZLMOA37VPKANP",<br>  "us-west-1": "Z24FKFUX50B4VW",<br>  "us-west-2": "Z18D5FSROUN65G"<br>}<br></pre> | no |
| PrivateDnszoneId | ZoneId where DNS record will be created for the RDSH nodes | `string` | `""` | no |
| RdpPrivateKeyS3Endpoint | S3 endpoint URL hosting the bucket where the RDP certificate private key is stored | `string` | `"https://s3.amazonaws.com"` | no |
| RepoBranchPrefixUrl | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/cfn/master"` | no |
| S3Bucket | n/a | `string` | `"your_bucket"` | no |
| ScaleDownDesiredCapacity | (Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset | `string` | `"1"` | no |
| ScaleDownSchedule | (Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. '0 0 \* \* \*') | `string` | `""` | no |
| ScaleUpSchedule | (Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. '0 10 \* \* Mon-Fri') | `string` | `""` | no |
| SubnetIDs | List of Subnet IDs where the RDSH instances and ELB will be launched | `list(string)` | `[]` | no |
| UpdateSchedule | (Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `""` | no |
| UserProfileDiskPath | Path to a CIFS share where User Profile Disks are stored, e.g. "\\home.example.com\Profiles$" | `string` | `"\\\\\\home.example.com\\Profile$"` | no |

## Outputs

No output.

<!-- END TFDOCS -->
