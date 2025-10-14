variable "location" {
  description = "The Azure region where resources will be deployed"
  type        = string
  default     = "North Central US"
}

variable "NS_Application" {
  description = "Application name for resource tagging"
  type        = string
  default     = "demoapp"
  
  validation {
    condition     = length(var.NS_Application) > 0 && length(var.NS_Application) <= 50
    error_message = "Application name must be between 1 and 50 characters."
  }
}

variable "NS_Environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "demo"
  
  validation {
    condition     = contains(["dev", "demo", "staging", "prod"], var.NS_Environment)
    error_message = "Environment must be one of: dev, demo, staging, prod."
  }
}

variable "appname" {
  description = "Base name for application resources"
  type        = string
  default     = "rlewisfinance"
  
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.appname)) && length(var.appname) <= 20
    error_message = "App name must contain only lowercase letters and numbers, max 20 characters."
  }
}



