- ***Anaconda***
```bash 
wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh #Check for newer release
bash Anaconda3-2021.11-Linux-x86_64.sh #Press "yes" to everything
source .bashrc #To run up Anaconda base
```
- ***Docker + Docker-compose***
```bash
sudo apt-get install docker.io # Start with Docker installation

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart #Relogin after last command
```
```bash
mkdir bin/ # To collect binaries (executable apps)
cd bin
wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O docker-compose
chmod +x docker-compose

nano .bashrc

# Add this stroke to the bottom of .bashrc and save it: $ export PATH="${HOME}/bin:${PATH}"

source .bashrc
```
- ***Terraform***
```bash
cd bin
wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip #Check for newer release
unzip https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip
rm https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip
```

- ***AWS***
# Setting Up an EC2 Instance with AWS Service Account Credentials

## Step 1: Sign Up for AWS
Before you can create an EC2 instance, you need to sign up for an AWS account. Go to the [AWS homepage](https://portal.aws.amazon.com/billing/signup) and follow the instructions to create an account.

## Step 2: Create an IAM User
For security reasons, it's best practice to use an IAM user with the necessary permissions rather than the root account.

1. Sign in to the AWS Management Console as the root user.
2. Navigate to the IAM service.
3. Create a new IAM user with administrative permissions.
4. Enable Multi-Factor Authentication (MFA) for added security.

## Step 3: Create a Key Pair
AWS uses key pairs for SSH access to EC2 instances.

1. In the EC2 dashboard, navigate to "Key Pairs".
2. Click "Create Key Pair".
3. Name your key pair and download it. Keep this file secure.

## Step 4: Launch an EC2 Instance
Now you're ready to create your EC2 instance.

1. Go back to the EC2 dashboard.
2. Click "Launch Instance".
3. Choose an Amazon Machine Image (AMI).
4. Select the instance type (e.g., t2.micro).
5. Configure instance details as needed.
6. Add storage if required.
7. Tag your instance for easier management.
8. Configure a security group to control access to the instance.
9. Review and launch your instance.

## Step 5: Access Your EC2 Instance
Once your instance is running, you can connect to it using SSH.

1. Locate your instance in the EC2 dashboard.
2. Select your instance and click "Connect".
3. Follow the instructions to use SSH with your key pair.

## Step 6: Store AWS Credentials on EC2
To store AWS service account credentials on your EC2 instance:

1. Connect to your EC2 instance via SSH.
2. Create a `.aws` directory in the home folder of the user that will run AWS commands.
3. Inside `.aws`, create a file named `credentials`.
4. Add your AWS credentials in the following format:

```plaintext
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

## Step 7: Verify Access
Test your setup by running a simple AWS CLI command to list S3 buckets:

`aws s3 ls`

If everything is set up correctly, you should see a list of S3 buckets.

## Conclusion
You now have an EC2 instance running with AWS service account credentials stored on it. Remember to follow AWS best practices for security and management.

```
Please replace the placeholders with your actual AWS credentials and information. Also, remember to follow AWS best practices, especially regarding the handling of AWS credentials. For a more secure approach, consider using IAM roles and instance profiles which can be attached directly to your EC2 instance without storing credentials on the instance itself. For detailed steps and additional options, refer to the official [AWS EC2 documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html).
```