# Infrastructure as Code (IaC)

This directory contains the Terraform configuration for the UI Upload application infrastructure, optimized for AWS Free Tier usage.

## Structure

```
infra/
├── environments/
│   ├── dev/
│   │   └── main.tf
│   └── prod/
│       └── main.tf
└── modules/
    ├── cognito/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── iam/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── s3/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Prerequisites

1. AWS CLI configured with appropriate credentials
2. Terraform installed (version >= 1.0.0)
3. S3 bucket for Terraform state (create manually)
4. DynamoDB table for Terraform state locking (create manually)

## Free Tier Considerations

### S3 Free Tier
- 5GB of storage
- 20,000 GET requests
- 2,000 PUT requests
- Lifecycle rules configured to optimize costs
- Intelligent-Tiering enabled for automatic cost optimization

### Cognito Free Tier
- 50,000 monthly active users
- Basic authentication features
- Email verification via Cognito
- Admin-only user creation
- Optimized token validity periods

### IAM
- No additional cost
- Follows least privilege principle

## Usage

### Development Environment

1. Navigate to the dev environment:
   ```bash
   cd environments/dev
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the changes:
   ```bash
   terraform apply
   ```

### Production Environment

1. Navigate to the prod environment:
   ```bash
   cd environments/prod
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the changes:
   ```bash
   terraform apply
   ```

## Resources Created

### S3 Module
- S3 bucket with versioning and encryption
- Public access blocking
- Lifecycle rules for cost optimization
- Intelligent-Tiering for automatic storage class optimization

### IAM Module
- IAM role for authenticated users
- IAM policy for S3 access
- Role attachment to Cognito Identity Pool

### Cognito Module
- User Pool with password policies
- User Pool Client with free tier optimizations
- Identity Pool
- Role attachments

## Security Considerations

1. All resources are tagged appropriately
2. S3 buckets have encryption enabled
3. Public access is blocked on S3 buckets
4. Cognito has proper password policies
5. IAM roles follow the principle of least privilege

## Maintenance

1. Always use `terraform plan` before applying changes
2. Keep the Terraform state in version control
3. Use workspaces for managing multiple environments
4. Regularly update the AWS provider version
5. Monitor Free Tier usage to avoid unexpected charges

## Resources Created

### S3 Module
- S3 bucket with versioning and encryption
- Public access blocking
- Proper bucket policies

### IAM Module
- IAM role for authenticated users
- IAM policy for S3 access
- Role attachment to Cognito Identity Pool

### Cognito Module
- User Pool with password policies
- User Pool Client
- Identity Pool
- Role attachments

## Security Considerations

1. All resources are tagged appropriately
2. S3 buckets have encryption enabled
3. Public access is blocked on S3 buckets
4. Cognito has proper password policies
5. IAM roles follow the principle of least privilege

## Maintenance

1. Always use `terraform plan` before applying changes
2. Keep the Terraform state in version control
3. Use workspaces for managing multiple environments
4. Regularly update the AWS provider version 