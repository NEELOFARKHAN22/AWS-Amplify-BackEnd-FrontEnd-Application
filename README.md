# Deploying a React.js Frontend and PHP Laravel Backend on EC2 using AWS CodeDeploy

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
