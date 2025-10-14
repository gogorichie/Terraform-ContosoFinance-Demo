#!/usr/bin/env pwsh

# Contoso Finance Terraform Cleanup Script
# This script helps safely destroy the infrastructure

Write-Host "🧹 Contoso Finance Infrastructure Cleanup" -ForegroundColor Yellow
Write-Host "=========================================" -ForegroundColor Yellow

# Warning message
Write-Host "⚠️  WARNING: This will destroy all infrastructure resources!" -ForegroundColor Red
Write-Host "⚠️  This action cannot be undone!" -ForegroundColor Red

# Show current resources
Write-Host "📋 Current resources that will be destroyed:" -ForegroundColor Yellow
terraform plan -destroy

# Double confirmation
$confirm1 = Read-Host "🤔 Are you absolutely sure you want to destroy all resources? Type 'destroy' to confirm"
if ($confirm1 -ne "destroy") {
    Write-Host "❌ Cleanup cancelled" -ForegroundColor Green
    exit 0
}

$confirm2 = Read-Host "🔴 Last chance! Type 'YES' in capital letters to proceed with destruction"
if ($confirm2 -ne "YES") {
    Write-Host "❌ Cleanup cancelled" -ForegroundColor Green
    exit 0
}

# Destroy resources
Write-Host "🧹 Destroying infrastructure..." -ForegroundColor Yellow
terraform destroy -auto-approve

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Infrastructure destroyed successfully" -ForegroundColor Green
    Write-Host "🧽 Cleaning up local files..." -ForegroundColor Yellow
    
    # Clean up terraform files
    if (Test-Path "tfplan") { Remove-Item "tfplan" -Force }
    if (Test-Path "terraform.tfstate.backup") { Remove-Item "terraform.tfstate.backup" -Force }
    
    Write-Host "✅ Cleanup completed!" -ForegroundColor Green
} else {
    Write-Host "❌ Destruction failed - please check for errors above" -ForegroundColor Red
    Write-Host "💡 You may need to manually clean up resources in the Azure Portal" -ForegroundColor Cyan
}