# Introduction 

This repository contains a sample Azure App Service and Terraform sample code to deploy it. This is a I used to demonstrate/test purposes only. Feel free to use these as you wish! and create an issue if you find any:) This project was inspired by [SoniaConti](https://github.com/SoniaConti) and her ARM project https://github.com/SoniaConti/ContosoFinance-Demo.


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


# Why Should you use Infrastructure as Code?

Infrastructure as code (IaC) enables you to automatically provision your environment with no manual intervention. For this demo we use JSON however the same resources can be deployed using different languages such as Bicep or Terraform.



# Architecture Design

![ArchitectureDesignDiagram](https://github.com/SoniaConti/ContosoFinance-Demo/blob/main/ContosoFinance-Demo-ARM/Images/ArchitectureDesginDiagram.PNG)

# What you will need

To deploy your first website using Azure App Service you will need
1. [Azure Subscription](https://azure.microsoft.com/en-us/free/)
2. [Visual Studio Code](https://code.visualstudio.com/download)
3. [GitHub Repository](github.com)

# Tagging Practices:

The following tags are applied to each resource created within the plan by default.

* NS_Environment
* NS_Application

# Deploy ContosoFinance Web App

1. Install Terraform [package](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. [Fork/copy](https://docs.microsoft.com/en-us/azure/devops/repos/git/forks?view=azure-devops&tabs=visual-studio#create-the-fork) this repo rep
3. Open the project locally with VSCode or your favorite text editor
4. Log into subscription wishing to deploy too with Az Login and set the root subscription as the active subscription:
    `az account set --subscription <<subscription id>>`
5.     terraform init
   - terraform plan
   - terraform apply



