variable "location" {
  type    = string
  default = "WestEurope"
}

variable "hostingplanname" {
  type    = string
  default = "ContosoFinance-Demo-Plan"
}

variable "webappname" {
  type    = string
  default = "ContosoFinance-Demo-Site"
}

variable "apiname" {
  type    = string
  default = "ContosoFinance-Demo-Api"
}

variable "sqlservername" {
  type    = string
  default = "ContosoFinance-Demo-Sql"
}

variable "databasename" {
  type    = string
  default = "contosofinancedemodb"
}

variable "skuName" {
  type    = string
  default = "F1"
}

variable "skuCapacity" {
  type    = number
  default = 1
}

variable "sqlAdministratorLogin" {
  type    = string
  default = "SysAdmin"
}

variable "sqlAdministratorLoginPassword" {
  type    = string
  default = "Ajsy37_8fhewkb9!29Cfbchda"
}

