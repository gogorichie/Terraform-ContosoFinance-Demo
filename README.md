# Introduction 

This repository contains a sample Azure App Service and Terraform sample code to deploy it. This is for demonstrate/test purposes only using IaC. Feel free to use these as you wish! and create an issue if you find any:) This project was inspired by [SoniaConti](https://github.com/SoniaConti) and her [ARM project](https://github.com/SoniaConti/ContosoFinance-Demo).
<br>
<br>
<br>

<p align="center">
    <img src ="https://img.shields.io/github/repo-size/gogorichie/Terraform-ContosoFinance-Demo" alt="Repository Size">
    <img src ="https://img.shields.io/github/languages/top/gogorichie/Terraform-ContosoFinance-Demo" alt="languages">
    <img src ="https://img.shields.io/github/last-commit/gogorichie/Terraform-ContosoFinance-Demo" alt="Last Commit">
    <img src ="https://img.shields.io/github/issues/gogorichie/Terraform-ContosoFinance-Demo?color=important" alt="Open Issues">
    <img src ="https://img.shields.io/github/issues-pr/gogorichie/Terraform-ContosoFinance-Demo?color=yellowgreen" alt="Open Pull Reqeusts">
</p>


In this project we will create a Website using Azure App Service.


#  What is Azure App Service?

Azure App Service is a Platform as a Service (PaaS), in other words it is a fully managed platform used for hosting web applications, like this one below, Mobile Apps, Logic Apps, API Apps and Function Apps.


# What is Terraform and why should you use it for your Infrastructure as Code (IaC?

![Terraform](https://github.com/gogorichie/Terraform-ContosoFinance-Demo/blob/master/images/terraform-color.png)

Terraform is an open-source tool created by HashiCorp that allows you to define and manage your infrastructure as code (IaC). It enables you to create, modify, and delete your infrastructure resources, such as virtual machines, load balancers, and databases, using a simple and declarative configuration language. Infrastructure as Code (IaC) is the practice of defining and managing your infrastructure resources using code, such as Terraform configuration files. By using IaC, you can automate your infrastructure provisioning and deployment processes, reduce human errors, and increase the consistency and reliability of your infrastructure.



# Architecture Design

![ArchitectureDesignDiagram](https://github.com/SoniaConti/ContosoFinance-Demo/blob/main/ContosoFinance-Demo-ARM/Images/ArchitectureDesginDiagram.PNG)

# Tagging Practices:

The following tags are applied to each resource created within the plan by default.

* NS_Environment
* NS_Application

# Deploy Contoso Finance Web App

## Prerequisites

1. **Install Required Tools:**
   - Install Terraform: `winget install Hashicorp.Terraform`
   - Install Azure CLI: `winget install Microsoft.AzureCLI`

2. **Clone/Fork Repository:**
   - [Fork this repository](https://docs.microsoft.com/en-us/azure/devops/repos/git/forks?view=azure-devops&tabs=visual-studio#create-the-fork)
   - Open locally with [Visual Studio Code](https://code.visualstudio.com/download)

## Quick Deployment (Recommended)

**Using the automated deployment script:**

```powershell
# Navigate to the project directory
cd c:\Deploy\Terraform-ContosoFinance-Demo-1

# Run the deployment script (handles authentication and deployment)
.\deploy.ps1
```

## Manual Deployment

**Step-by-step manual deployment:**

```powershell
# 1. Login to Azure
az login

# 2. Set your target subscription
az account set --subscription "Your-Subscription-Name-or-ID"

# 3. Initialize Terraform
terraform init

# 4. Validate configuration
terraform validate

# 5. Create deployment plan
terraform plan -out=tfplan

# 6. Apply the deployment
terraform apply tfplan
```

## Configuration Options

Create a `terraform.tfvars` file to customize your deployment:

```hcl
location        = "East US 2"
NS_Application  = "your-app-name"
NS_Environment  = "demo"  # dev, demo, staging, prod
appname         = "your-unique-app-name"
```

## Resource Cleanup

**To destroy all resources:**

```powershell
# Using the cleanup script (recommended)
.\cleanup.ps1

# Or manually
terraform destroy
```

## What Gets Deployed

- **Resource Group** - Container for all resources
- **App Service Plan** - Hosting plan (B1 for demo, P1v3 for prod)
- **Web Apps** - Main site and API endpoints
- **SQL Server & Database** - Backend database with firewall rules
- **Key Vault** - Secure storage for secrets (with purge protection)
- **Storage Account** - Blob storage for application data
- **Application Insights** - Application monitoring and analytics
- **Log Analytics Workspace** - Centralized logging
- **Stream Analytics Job** - Real-time data processing

## Security Features

- ✅ HTTPS-only web applications
- ✅ Key Vault with purge protection enabled
- ✅ Minimum TLS 1.2 for all services
- ✅ Private storage containers
- ✅ Restricted SQL Server firewall rules
- ✅ Application Insights integration

## Monitoring & Outputs

After deployment, check the outputs for:
- Web application URLs
- Database connection information
- Key Vault URI
- Application Insights connection string

Visit the Azure Portal to monitor your resources and set up alerts.



