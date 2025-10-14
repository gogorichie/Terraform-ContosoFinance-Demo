#!/usr/bin/env pwsh

# Contoso Finance Terraform Deployment Script
# This script helps deploy the infrastructure with proper authentication

Write-Host "🚀 Contoso Finance Infrastructure Deployment" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green

# Check if Azure CLI is installed and working
Write-Host "📋 Checking prerequisites..." -ForegroundColor Yellow

try {
    $azVersion = az --version 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Azure CLI not found or not working"
    }
    Write-Host "✅ Azure CLI is installed" -ForegroundColor Green
}
catch {
    Write-Host "❌ Azure CLI is not installed or not working properly" -ForegroundColor Red
    Write-Host "💡 Please install Azure CLI using: winget install Microsoft.AzureCLI" -ForegroundColor Cyan
    Write-Host "💡 Then restart PowerShell and run this script again" -ForegroundColor Cyan
    exit 1
}

# Check if Terraform is installed
try {
    $tfVersion = terraform version
    if ($LASTEXITCODE -ne 0) {
        throw "Terraform not found"
    }
    Write-Host "✅ Terraform is installed" -ForegroundColor Green
}
catch {
    Write-Host "❌ Terraform is not installed" -ForegroundColor Red
    Write-Host "💡 Please install Terraform using: winget install Hashicorp.Terraform" -ForegroundColor Cyan
    exit 1
}

# Check Azure login status
Write-Host "🔐 Checking Azure authentication..." -ForegroundColor Yellow
$accountInfo = az account show 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged into Azure" -ForegroundColor Red
    Write-Host "🔓 Attempting Azure login..." -ForegroundColor Yellow
    az login
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Azure login failed" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Azure authentication successful" -ForegroundColor Green

# Show current subscription
$subscription = az account show --query "{name:name, id:id}" -o table
Write-Host "📊 Current Azure subscription:" -ForegroundColor Yellow
Write-Host $subscription

# Confirm deployment
$confirm = Read-Host "🤔 Do you want to proceed with deployment? (y/N)"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "❌ Deployment cancelled" -ForegroundColor Red
    exit 0
}

# Initialize Terraform
Write-Host "🔄 Initializing Terraform..." -ForegroundColor Yellow
terraform init
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform initialization failed" -ForegroundColor Red
    exit 1
}

# Validate configuration
Write-Host "✅ Validating Terraform configuration..." -ForegroundColor Yellow
terraform validate
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform validation failed" -ForegroundColor Red
    exit 1
}

# Plan deployment
Write-Host "📋 Creating deployment plan..." -ForegroundColor Yellow
terraform plan -out=tfplan
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform plan failed" -ForegroundColor Red
    exit 1
}

# Apply deployment
Write-Host "🚀 Applying deployment..." -ForegroundColor Yellow
terraform apply tfplan
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Terraform apply failed" -ForegroundColor Red
    exit 1
}

Write-Host "🎉 Deployment completed successfully!" -ForegroundColor Green
Write-Host "🌐 Check the outputs above for your application URLs" -ForegroundColor Cyan
Write-Host "📱 Visit the Azure Portal to view your resources:" -ForegroundColor Cyan
$resourceGroup = terraform output -raw resource_group_name 2>$null
if ($resourceGroup) {
    Write-Host "🔗 https://portal.azure.com/#@/resource/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$resourceGroup" -ForegroundColor Blue
}