variable "tags" {
  type        = any
  default     = {}
  description = "mapping of tags to assign, default settings are defined within locals and merged with var settings"
}
# resource definition/configuration
variable "key_vault_secret" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "user" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "group" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "application" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "application_password" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "service_principal" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "service_principal_password" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "role_assignment" {
  type    = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}

locals {
    tags = {}
    # resource definition
    key_vault_secret = {
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

  # merge custom and default values
  tags = merge(local.default.tags, var.tags)

  # deep merge over merged config and use defaults if no variable is set
  key_vault_secret = {
    # get all config
    for config in keys(var.key_vault_secret) :
    config => merge(local.default.key_vault_secret, var.key_vault_secret[config])
  }
  user = {
    # get all config
    for config in keys(var.user) :
    config => merge(local.default.user, var.user[config])
  }
  group = {
    # get all config
    for config in keys(var.group) :
    config => merge(local.default.group, var.group[config])
  }
  application = {
    # get all config
    for config in keys(var.application) :
    config => merge(local.default.application, var.application[config])
  }
  application_password = {
    # get all config
    for config in keys(var.application_password) :
    config => merge(local.default.application_password, var.application_password[config])
  }
  service_principal = {
    # get all config
    for config in keys(var.service_principal) :
    config => merge(local.default.service_principal, var.service_principal[config])
  }
  service_principal_password = {
    # get all config
    for config in keys(var.service_principal_password) :
    config => merge(local.default.service_principal_password, var.service_principal_password[config])
  }
  role_assignment = {
    # get all config
    for config in keys(var.role_assignment) :
    config => merge(local.default.role_assignment, var.role_assignment[config])
  }
}
