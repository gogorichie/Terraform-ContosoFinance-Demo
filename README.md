# Introduction 

This repository contains a sample Azure App Service and Terraform sample code to deploy it. This is for demonstrate/test purposes only using IaC. Feel free to use these as you wish! and create an issue if you find any:) This project was inspired by [SoniaConti](https://github.com/SoniaConti) and her [ARM project](https://github.com/SoniaConti/ContosoFinance-Demo).


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

1. Install Terraform [package](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. [Fork/copy](https://docs.microsoft.com/en-us/azure/devops/repos/git/forks?view=azure-devops&tabs=visual-studio#create-the-fork) this repo rep
3. Open the project locally with [Visual Studio Code](https://code.visualstudio.com/download) or your favorite text editor
4. Log into your [Azure Subscription](https://azure.microsoft.com/en-us/free/) wishing to deploy too with Az Login and set the root subscription as the active subscription:
    `az account set --subscription <<subscription id>>`
5.     terraform init
   - terraform plan
   - terraform apply



