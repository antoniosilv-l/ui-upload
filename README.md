# UI File Upload System

A Streamlit application for managing file uploads to AWS S3 buckets with AWS Cognito authentication.

## Features

- AWS Cognito user authentication
- File upload to specific S3 buckets
- List files from buckets
- Secure credential management

## Setup

1. Install the required dependencies:
```bash
pip install -r requirements.txt
```

2. Create a `.env` file with your AWS configuration:
```
AWS_REGION=your-region
USER_POOL_ID=your-user-pool-id
CLIENT_ID=your-client-id
IDENTITY_POOL_ID=your-identity-pool-id
```

3. Run the application:
```bash
streamlit run app.py
```

## AWS Setup Requirements

1. Create a Cognito User Pool
2. Create a Cognito Identity Pool
3. Create S3 buckets for file storage
4. Configure appropriate IAM roles and policies

## Usage

1. Login with your AWS Cognito credentials
2. Enter the target bucket name
3. Upload files using the file uploader
4. List files in the bucket using the "List Files" button
5. Logout when finished

## Security Notes

- Never commit your `.env` file to version control
- Ensure proper IAM roles and policies are configured
- Use appropriate bucket policies for access control
