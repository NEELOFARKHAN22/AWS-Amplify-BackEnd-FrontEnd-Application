# Deploying a React.js Frontend and PHP Laravel Backend on EC2 using AWS CodePipeline

## Project Description

This project demonstrates the deployment of a React.js frontend application and a PHP Laravel backend application on Amazon EC2 instances using AWS CodeDeploy. The infrastructure is designed to be secure, highly available, and scalable. AWS Secret Manager is used for managing environment variables, and Amazon RDS MySQL is used as the database service. The React.js frontend includes sign-in and sign-up pages for user authentication.

## Tools and Technologies

| Tool/Technology   | Use Case                                                                                 |
|-------------------|------------------------------------------------------------------------------------------|
| React.js          | Frontend framework for building user interfaces with a focus on single-page applications |
| PHP Laravel       | Backend framework for building web applications and APIs                                 |
| AWS EC2           | Compute service to host the React.js frontend and PHP Laravel backend                    |
| AWS CodeDeploy    | Deployment service for automating application updates                                    |
| AWS Secret Manager| Securely store and manage sensitive information, such as environment variables           |
| Amazon RDS MySQL  | Managed relational database service                                                      |
| IAM               | Manage access and permissions securely                                                   |
| Security Groups   | Control inbound and outbound traffic to EC2 instances                                    |
| VPC               | Isolated network to host AWS resources                                                   |

## Project Structure

The project is structured to ensure high availability, security, and scalability. Below are the key components and their configurations:

1. **Frontend (React.js)**
    - Contains sign-in and sign-up pages.
    - Deployed on EC2 instances behind a load balancer for high availability.
    - Environment variables managed using AWS Secret Manager.

2. **Backend (PHP Laravel)**
    - Provides API endpoints for user authentication and other application features.
    - Deployed on EC2 instances behind a load balancer.
    - Connects to Amazon RDS MySQL for database operations.
    - Environment variables managed using AWS Secret Manager.

3. **Database (Amazon RDS MySQL)**
    - Managed relational database for storing user data and application data.

4. **Deployment (AWS CodeDeploy)**
    - Automates the deployment process for both frontend and backend applications.
    - Uses `buildspec.yml` and `appspec.yml` files for configuration.
      

## Deployment Steps

### 1. Setup AWS Environment

#### Create a VPC
- Open the **VPC Dashboard** in AWS.
- Click on **Create VPC**.
- Choose **VPC with Public and Private Subnets**.
- Fill in the necessary details like VPC name, IPv4 CIDR block, etc.
- Click **Create VPC** and note down the VPC ID.

#### Launch an EC2 Instance
- Go to the **EC2 Dashboard**.
- Click on **Launch Instance**.
- Choose an **Amazon Machine Image (AMI)** (e.g., Ubuntu Server 22.04 LTS).
- Select an **Instance Type** (e.g., t2.micro).
- Click **Next: Configure Instance Details**.
- In **Network**, select the VPC you created.
- In **Subnet**, select one of the public subnets.
- Ensure **Auto-assign Public IP** is enabled.
- Click **Next: Add Storage** and adjust storage if needed.
- Click **Next: Add Tags** and add tags if desired.
- Click **Next: Configure Security Group**.
- Create a new security group with rules to allow HTTP (port 80) and SSH (port 22) traffic.
- Click **Review and Launch**.
- Click **Launch** and create a new key pair or select an existing key pair.
- Click **Launch Instances**.

### 2. Setup IAM Roles and Policies

#### Create an IAM Role for the EC2 Instance
- Open the **IAM Dashboard**.
- Click on **Roles** in the sidebar.
- Click on **Create role**.
- Select **EC2** as the trusted entity.
- Click **Next: Permissions**.
- Attach the following policies:
  - `AmazonEC2RoleforAWSCodeDeploy`
  - `AmazonS3ReadOnlyAccess`
  - `SecretsManagerReadWrite`
  - `AWSCodePipelineCustomActionAccess`
  - `CloudWatchLogsFullAccess`
- Click **Next: Tags** (add tags if needed) and then **Next: Review**.
- Give the role a name (e.g., `EC2CodeDeployRole`).
- Click **Create role**.

#### Attach the IAM Role to the EC2 Instance
- Go to the **EC2 Dashboard**.
- Select the instance you launched.
- Click on **Actions** > **Security** > **Modify IAM Role**.
- Select the IAM role you created (e.g., `EC2CodeDeployRole`).
- Click **Update IAM role**.

#### Create an IAM Role for CodeDeploy
- Open the **IAM Dashboard**.
- Click on **Roles** in the sidebar.
- Click on **Create role**.
- Select **CodeDeploy** as the trusted entity.
- Click **Next: Permissions**.
- Attach the `AWSCodeDeployRole` policy.
- Click **Next: Tags** (add tags if needed) and then **Next: Review**.
- Give the role a name (e.g., `CodeDeployRole`).
- Click **Create role**.

### 1. Create an Amazon RDS MySQL Database

- **Open the RDS Dashboard**
  - Log in to the AWS Management Console.
  - Navigate to the **RDS Dashboard**.

- **Create a Database**
  - Click on **Create database**.
  - Select **Easy Create**.
  - Choose **MySQL** as the engine.
  - Select the **Free Tier** option.

- **Configure Database Settings**
  - Set the **DB instance identifier** (e.g., `mydatabase`).
  - Create a **Master username** and **Master password**. Note these credentials.
  - Choose the **db.t2.micro** instance class.

- **Set Storage Options**
  - Use the default storage options to stay within Free Tier limits.

- **Configure Connectivity**
  - Select the VPC where your EC2 instance resides.
  - Ensure **Public accessibility** is set to **Yes** if you need to connect from outside the VPC.
  - Choose the existing security group associated with your EC2 instance.

- **Create the Database**
  - Click **Create database**.
  - Wait for the database to be created. This may take a few minutes.

#### 2. **Configure Security Groups**

- **Modify Security Groups for RDS**
  - Go to the **EC2 Dashboard**.
  - Click on **Security Groups** in the left sidebar.
  - Select the security group associated with your EC2 instance.
  - Click **Inbound rules** > **Edit inbound rules**.
  - Add a new rule:
    - **Type**: MySQL/Aurora
    - **Protocol**: TCP
    - **Port Range**: 3306
    - **Source**: Custom (Enter the security group ID of your EC2 instance)

- **Save Rules**
  - Click **Save rules** to apply the changes.

#### 3. **Attach RDS to the EC2 Instance**

- **Retrieve RDS Endpoint**
  - Go to the **RDS Dashboard**.
  - Select your database instance.
  - Copy the **Endpoint** (host) and **Port**.

- **Connect from EC2**
  - SSH into your EC2 instance.
  - Install MySQL client if not already installed: 
    ```sh
    sudo apt update
    sudo apt install mysql-client -y
    ```

- **Test Connection**
  - Connect to your RDS instance using the MySQL client:
    ```sh
    mysql -h <RDS_ENDPOINT> -P 3306 -u <MasterUsername> -p
    ```
  - Enter the master password when prompted.
    
## React Frontend Application Deployment using AWS CodePipeline

#### **Repository URL**
[https://github.com/NEELOFARKHAN22/test.git](https://github.com/NEELOFARKHAN22/test.git)

#### **Repository Structure**
- **public/**: Contains the public assets for the React application.
- **scripts/**: Contains deployment scripts.
- **src/**: Contains the source code for the React application.
- **README.md**: This file.
- **appspec.yml**: AWS CodeDeploy configuration file.
- **buildspec.yml**: AWS CodeBuild configuration file.
- **package-lock.json**: Dependency tree lock file.
- **package.json**: Project metadata and dependencies.

### **Setup Steps**

### **Step 1: Set Up AWS CodePipeline**

#### Create a CodeCommit Repository
1. Create a new CodeCommit repository.
2. Push code to this repository.

#### Create a CodeBuild Project
1. Go to the AWS CodeBuild console and create a new project.
2. Specify the build environment as:
   - `Managed Image`
   - `Ubuntu operating system`
   - `Node.js runtime`
3. In the Buildspec section, use the provided `buildspec.yml`.
   
#### Create a CodeDeploy Application

1. Go to the AWS CodeDeploy console and create a new application.
2. Specify the deployment type as:
   - EC2/On-premises
3. Create a new deployment group and specify the EC2 instances for deployment.
4. Use the provided `appspec.yml` file.
   
#### Create a CodePipeline

1. Go to the AWS CodePipeline console and create a new pipeline.
2. Add a source stage with your CodeCommit repository.
3. Add a build stage with your CodeBuild project.
4. Add a deploy stage with your CodeDeploy application and deployment group.
### buildspec.yml file
```yaml
version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 14

    commands:
      # Install dependencies
      - npm install

  build:
    commands:
      - npm run-script build

artifacts:
  # Include all the files required to run the application
  files:
    - '**/*'
```
### appspec.yml file
```yaml
version: 0.0
os: linux
files:
hooks:
  AfterInstall:
    - location: scripts/after_install.sh
      runas: ubuntu
```
### AfterInstall Script (scripts/after_install.sh)
```bash
#!/bin/bash
# after install script

app_dir="/var/www/html/admin"
current_dir="/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive"

cd "$current_dir"

sudo chown -R www-data:www-data "$current_dir"

if [ -L "$app_dir" ]; then
    sudo unlink "$app_dir"
fi

sudo ln -s "$current_dir" "$app_dir"
```
### **Steps for Deployment**
1. **Push Changes:** Push any changes to your CodeCommit repository.
2. **Monitor Pipeline:** Go to the CodePipeline console and monitor the pipeline execution.
3. **Verify Deployment:** Once the pipeline completes, verify that the application is deployed and running on your EC2 instance.
