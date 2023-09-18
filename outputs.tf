output "key_vault_secret" {
  description = "azurerm_key_vault_secret results"
  value = {
    for key_vault_secret in keys(azurerm_key_vault_secret.key_vault_secret) :
    key_vault_secret => {
      name  = azurerm_key_vault_secret.key_vault_secret[key_vault_secret].name
      value = azurerm_key_vault_secret.key_vault_secret[key_vault_secret].value
    }
  }
}

output "user" {
  description = "azuread_user results"
  value = {
    for user in keys(azuread_user.user) :
    user => {
      id                  = azuread_user.user[user].id
      display_name        = azuread_user.user[user].display_name
      user_principal_name = azuread_user.user[user].user_principal_name
    }
  }
}

output "group" {
  description = "azuread_group results"
  value = {
    for group in keys(azuread_group.group) :
    group => {
      id           = azuread_group.group[group].id
      display_name = azuread_group.group[group].display_name
    }
  }
}

output "application" {
  description = "azuread_application results"
  value = {
    for application in keys(azuread_application.application) :
    application => {
      application_id = azuread_application.application[application].application_id
      object_id      = azuread_application.application[application].object_id
    }
  }
}

output "application_password" {
  description = "azuread_application_password results"
  value = {
    for application_password in keys(azuread_application_password.application_password) :
    application_password => {
      display_name = azuread_application_password.application_password[application_password].display_name
      key_id       = azuread_application_password.application_password[application_password].key_id
      value        = azuread_application_password.application_password[application_password].value
    }
  }
}

output "service_principal" {
  description = "azuread_service_principal results"
  value = {
    for service_principal in keys(azuread_service_principal.service_principal) :
    service_principal => {
      display_name = azuread_service_principal.service_principal[service_principal].display_name
      object_id    = azuread_service_principal.service_principal[service_principal].object_id
    }
  }
}

output "service_principal_password" {
  description = "azuread_service_principal_password results"
  value = {
    for service_principal_password in keys(azuread_service_principal_password.service_principal_password) :
    service_principal_password => {
      key_id       = azuread_service_principal_password.service_principal_password[service_principal_password].key_id
      display_name = azuread_service_principal_password.service_principal_password[service_principal_password].display_name
      end_date     = azuread_service_principal_password.service_principal_password[service_principal_password].end_date
      value        = azuread_service_principal_password.service_principal_password[service_principal_password].value
    }
  }
}

output "user_assigned_identity" {
  description = "Outputs all attributes of resource_type."
  value = {
    for user_assigned_identity in keys(azurerm_user_assigned_identity.user_assigned_identity) :
    user_assigned_identity => {
      for key, value in azurerm_user_assigned_identity.user_assigned_identity[user_assigned_identity] :
      key => value
    }
  }
}

output "variables" {
  description = "Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module"
  value = {
    default = {
      for variable in keys(local.default) :
      variable => local.default[variable]
    }
    merged = {
      key_vault_secret = {
        for key in keys(var.key_vault_secret) :
        key => local.key_vault_secret[key]
      }
      user = {
        for key in keys(var.user) :
        key => local.user[key]
      }
      group = {
        for key in keys(var.group) :
        key => local.group[key]
      }
      group_member	 = {
        for key in keys(var.group_member) :
        key => local.group_member[key]
      }
      application = {
        for key in keys(var.application) :
        key => local.application[key]
      }
      application_password = {
        for key in keys(var.application_password) :
        key => local.application_password[key]
      }
      service_principal = {
        for key in keys(var.service_principal) :
        key => local.service_principal[key]
      }
      service_principal_password = {
        for key in keys(var.service_principal_password) :
        key => local.service_principal_password[key]
      }
      app_role_assignment = {
        for key in keys(var.app_role_assignment) :
        key => local.app_role_assignment[key]
      }
      user_assigned_identity = {
        for key in keys(var.user_assigned_identity) :
        key => local.user_assigned_identity[key]
      }
    }
  }
}
