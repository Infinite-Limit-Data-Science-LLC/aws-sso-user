# Executive Summary

Setting up the IAM Identity Center in AWS requires ClickOps. Once the Identity Center has been provisioned, it will automatically configure an AWS Organization with a default Root. The "Organization Root" refers to the top-level entity that represents an organization within the AWS Management Console. Since there will only be one account by default (the account used to create the Identity Center), your account will be automatically set as the "Management Account".

Note instead of using an IAM User to provision the initial setup of your Identity Center, instead of using an IAM User in your Managerial Account, create a User with ClickOps in AWS IAM Identity Center, which is the AWS recommended best practice for managing your AWS account authentication. ClickOps is necessary; otherwise, you will have a chicken and egg problem. How can you provision IaC to AWS if you do not have access to AWS? Creating an IAM User and associating with an IAM Role, even when using STS Service for temporary role access, is not recommended by AWS. For example, if you attempt to create an IAM User to leverage the AWS CLI through your IaC, AWS will show a warning: "Use the AWS CLI V2 and enable authentication through a user in IAM Identity Center." Note inside the Terraform providers block, do not explicitly set credentials as this will automatically be configured in the CI/CD platform.

Note when you use ClickOps to create the initial user, and if you specify an email, an email will be sent to the email address specified wherin you are prompted to accept the invitation. **You do not need to specify an email! Instead, you can provision a user for a specific purpose and generate a onetime password that you can share with the user. Then they can log into the AWS Console with the created username and password.** You are taken to an AWS screen where you specify a password. During the creation of the Identity Center, you should specify "tenant-administrator" as the username, indicating this is the admin user for your IaC setup. Note when you create the tenant-administrator, AWS prompts you to register an MFA device.

The ClickOps tenant-administrator will require a Permission Set. For the tenant-administrator, you can configure a predefined Permission Set using an AWS-defined template. AWS provides an AWS Managed policy called "AdministratorAccess". When you create a Permission Set, you can define a Session Duration. The Permission Set defines the length of time a user can be logged on before the console logs them out of their session. The default is 1 hour. Finally, associate the tenant-administrator with your AWS accounts via IAM Identity Center > Multi-account permissions > AWS accounts.

Use the examples/basic-usage folder to test the infra out locally or deploy to a sandbox account. This is not intended to be used in stage or production environments. State should be managed as remote state, using Amazon S3 and locking handled by DynamoDB (in the case of AWS). However, the benefit of using examples/basic-usage is it allows you to test the infra and also inspect state that has been created (e.g. terraform state list, terraform state show aws_instance).

# Usage

```code
cd examples/basic-usage
terraform init
terraform plan
terraform apply
terraform destroy
```

# End-to-End Testing

Terraform is software written in the Go programming language. In effect, writing end-to-end infrastructure testing is usually done in Go as well. Configure your testing first:

```shell
cd test
go mod init "<MODULE_NAME>"
go mod tidy
```

And then run the tests:

```shell
cd test
go test -v -timeout 30m
```