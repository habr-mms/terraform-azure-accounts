variable "key_vault_secret" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "user" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "group" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "application" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "application_password" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "service_principal" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "service_principal_password" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "role_assignment" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

locals {
  default = {
    # resource definition
    key_vault_secret = {
      name         = ""
      content_type = ""
    }
    user = {
      display_name          = ""
      account_enabled       = true
      password              = "change_IT#9"
      force_password_change = true
      show_in_address_list  = false
    }
    group = {
      description             = "group"
      assignable_to_role      = false
      members                 = []
      owners                  = []
      prevent_duplicate_names = true
      security_enabled        = true
      mail_enabled            = false
    }
    application = {
      owners                  = []
      prevent_duplicate_names = true
    }
    application_password = {
      display_name = ""
      end_date     = "2099-01-01T00:00:00Z"
    }
    service_principal = {
      account_enabled              = true
      app_role_assignment_required = false
      description                  = ""
      owners                       = []
    }
    service_principal_password = {
      rotation = ""
    }
    role_assignment = {
      role_definition_name = "Reader"
    }
  }

  # compare and merge custom and default values
  # merge all custom and default values
  key_vault_secret = {
    for key_vault_secret in keys(var.key_vault_secret) :
    key_vault_secret => merge(local.default.key_vault_secret, var.key_vault_secret[key_vault_secret])
  }
  user = {
    for user in keys(var.user) :
    user => merge(local.default.user, var.user[user])
  }
  group = {
    for group in keys(var.group) :
    group => merge(local.default.group, var.group[group])
  }
  application = {
    for application in keys(var.application) :
    application => merge(local.default.application, var.application[application])
  }
  application_password = {
    for application_password in keys(var.application_password) :
    application_password => merge(local.default.application_password, var.application_password[application_password])
  }
  service_principal = {
    for service_principal in keys(var.service_principal) :
    service_principal => merge(local.default.service_principal, var.service_principal[service_principal])
  }
  service_principal_password = {
    for service_principal_password in keys(var.service_principal_password) :
    service_principal_password => merge(local.default.service_principal_password, var.service_principal_password[service_principal_password])
  }
  role_assignment = {
    for role_assignment in keys(var.role_assignment) :
    role_assignment => merge(local.default.role_assignment, var.role_assignment[role_assignment])
  }
}
