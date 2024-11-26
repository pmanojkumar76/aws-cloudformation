
# AWS CloudFormation: EC2 Instance and Network Setup

This repository contains resources and instructions to deploy an EC2 instance in a public VPC using AWS CloudFormation. It includes necessary networking components, security configurations, and additional documentation.

## Repository Structure

```
aws-cloudformation-ec2/
│
├── cloudformation-template.yaml     # CloudFormation script
├── IAM-policy.json                  # Required IAM policy document
├── test-connectivity.sh             # Optional script to test port 22 connectivity
└── README.md                        # Documentation and instructions
```

---

## CloudFormation Template

The `cloudformation-template.yaml` file is a YAML-based CloudFormation template designed to:

1. Create a VPC, Subnet, Internet Gateway, Route Table, and Security Group.
2. Launch an EC2 instance within the created public subnet.
3. Configure the instance to allow inbound SSH (TCP port 22) connections from any IP address.

### Prerequisites

- An existing AWS Key Pair. Replace the `KeyName` parameter in the CloudFormation template with your Key Pair name.
- AWS CLI installed and configured with appropriate credentials.

### How to Deploy

1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/aws-cloudformation-ec2.git
   cd aws-cloudformation-ec2
   ```

2. Deploy the CloudFormation stack using the AWS CLI:
   ```bash
  aws cloudformation create-stack --stack-name MyEC2Stack \
  --template-body file://cloudformation-template.yaml \
  --parameters ParameterKey=KeyName,ParameterValue=<YourKeyName> \
  --region us-east-1
   ```

3. Replace '<YourKeyName>' with your .pem file name and `<YourAWSRegion>` with your preferred AWS region.

4. Once deployed, find the public IP of the EC2 instance in the AWS Console or using the AWS CLI.

---

## IAM Policy

The `IAM-policy.json` file contains the permissions required to deploy the CloudFormation stack. Ensure the IAM role or user running the deployment has these permissions.

### IAM Policy Overview

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudformation:CreateStack",
        "cloudformation:DeleteStack",
        "cloudformation:DescribeStacks",
        "cloudformation:UpdateStack"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:RunInstances",
        "ec2:TerminateInstances",
        "ec2:DescribeInstances",
        "ec2:CreateSecurityGroup",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateKeyPair",
        "ec2:DescribeKeyPairs",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "vpc:CreateVpc",
        "vpc:DeleteVpc",
        "vpc:DescribeVpcs",
        "vpc:CreateSubnet",
        "vpc:DeleteSubnet",
        "vpc:CreateInternetGateway",
        "vpc:AttachInternetGateway",
        "vpc:CreateRouteTable",
        "vpc:AssociateRouteTable",
        "vpc:DescribeRouteTables"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "*"
    }
  ]
}
```

---

## Testing Connectivity

The `test-connectivity.sh` script can be used to verify the EC2 instance is reachable on TCP port 22.

### How to Use

1. Find the public IP address of your EC2 instance (from AWS Console or CLI).
2. Run the script:
   ```bash
   ./test-connectivity.sh <PublicIP>
   ```

3. Replace `<PublicIP>` with the EC2 instance's public IP address.

If the connection succeeds, you should see a response indicating the connection to port 22 is established.

---

## Notes and Best Practices

- **Security**: The Security Group allows SSH from all IPs (`0.0.0.0/0`). For production, restrict access to specific IP ranges.
- **AMI**: The template uses Amazon Linux 2. Update the AMI ID if deploying in a different region.
- **Costs**: Ensure you terminate the EC2 instance and associated resources after testing to avoid unexpected charges.

---

## Cleanup

To delete the stack and resources created by the template, use the following command:

```bash
aws cloudformation delete-stack --stack-name MyEC2Stack
```

---

## Contact

For any questions or issues, please feel free to contact me at :

Email: phanikumart06@gmail.com