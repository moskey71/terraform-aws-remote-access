variable "AmiId" {
  default     = ""
  description = "(Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString"
  type        = string
}

variable "AmiNameSearchString" {
  default     = "Windows_Server-2016-English-Full-Base-*"
  description = "Search pattern to match against an AMI Name"
  type        = string
}

variable "CloudWatchAgentUrl" {
  default     = ""
  description = "(Optional) HTTPS URL to CloudWatch Agent installer. Example: https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
  type        = string
}

variable "DataVolumeSize" {
  default     = "50"
  description = "Size of the data volume to attach to the instance"
  type        = string
}

variable "DataVolumeSnapshotId" {
  default     = ""
  description = "(Optional) Snapshot ID of an existing EBS volume. Leave blank to instantiate an empty volume"
  type        = string
}

variable "DomainAccessUserGroup" {
  default     = "yourgroupname"
  description = "Domain group of users authorized to use the remote access solution"
  type        = string
}

variable "DomainDirectoryId" {
  default     = "d-xxxxxxxxxx"
  description = "ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx"
  type        = string
}

variable "DomainDnsName" {
  default     = "ad.example.com"
  description = "Fully qualified domain name (FQDN) of the forest root domain, e.g. example.com"
  type        = string
}

variable "DomainNetbiosName" {
  default     = "example"
  description = "NetBIOS name of the domain (e.g. EXAMPLE)"
  type        = string
}

variable "Ec2SubnetAz" {
  default     = "us-east-1a"
  description = "Availability zone of the private subnet"
  type        = string
}

variable "Ec2SubnetId" {
  default     = "subnet-xxxxxxxx"
  description = "Private Subnet ID where the file server will run"
  type        = string
}

variable "ExtraSecurityGroupIds" {
  default     = []
  description = "List of extra Security Group IDs to attach to the RDCB EC2 instance"
  type        = list(string)
}

variable "ForceCfnInitUpdate" {
  default     = "A"
  description = "Toggles a cfn-init metadata update even if nothing else changes"
  type        = string
}

variable "InstanceType" {
  default     = "t2.medium"
  description = "Amazon EC2 instance type for the Remote Desktop Session Instance"
  type        = string
}

variable "KeyPairName" {
  default     = "yourkeypair"
  description = "Public/private key pairs allow you to securely connect to your instance after it launches"
  type        = string
}

variable "NoPublicIp" {
  default     = "true"
  description = "Controls whether to assign the instances a public IP. Recommended to leave at 'true' _unless_ launching in a public subnet"
  type        = string
}

variable "NotificationEmail" {
  default     = ""
  description = "(Optional) Email address to subscribe to notifications and alarms"
  type        = string
}

variable "PatchSchedule" {
  default     = "cron(0 6 ? * Sat *)"
  description = "Schedule used to apply patches to the instance"
  type        = string
}

variable "PatchSnsTopicArn" {
  default     = ""
  description = "SNS Topic used for patch status notifications"
  type        = string
}

variable "RdcbDnszoneId" {
  default     = ""
  description = "Zone to create DNS record for RDCB instance"
  type        = string
}

variable "RepoBranchPrefixUrl" {
  default     = "https://raw.githubusercontent.com/plus3it/cfn/master"
  description = "URL prefix where the repo scripts can be retrieved"
  type        = string
}

variable "S3Bucket" {
}

variable "SecurityGroupIngress" {
  default     = []
  description = "List of security group IPs to allow"
  type        = list(string)
}

variable "SnapshotFrequency" {
  default     = "60"
  description = "(Optional) Specify an interval in minutes to configure snapshots of the EBS fileshare volume. Set an empty value \"\" to skip configuring snapshots. Default interval is 60 minutes."
  type        = string
}

variable "SsmKeyId" {
  default     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  description = "KMS Key ID used to encrypt/decrypt the SsmRdcbCredential"
  type        = string
}

variable "SsmRdcbCredential" {
  default     = "/your-path/rdcb/credential"
  description = "SSM Parameter Name for a SecureString containing the domain credential for the RDCB service account. SSM Parameter Value format is '@{Username = \"<user>\"; Password = \"<password>\"}'"
  type        = string
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
  type        = string
}

variable "TerminationProtection" {
  default     = true
  description = "Enable or disable instance termination protection.  Protection is enabled by default."
  type        = string
}

variable "VpcId" {
  default     = "vpc-12345678"
  description = "VPC to deploy instance into"
  type        = string
}

