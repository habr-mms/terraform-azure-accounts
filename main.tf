/**
 * # accounts
 *
 * This module manages Azure AD Resources and Permissions.
 *
*/

/** KeyVault Secret */
resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = local.key_vault_secret

  name         = each.key
  value        = local.key_vault_secret[each.key].value
  key_vault_id = local.key_vault_secret[each.key].key_vault_id
  content_type = local.key_vault_secret[each.key].content_type

  tags = {
    for tag in keys(local.tags) :
    tag => local.tags[tag]
  }
}

/** User */
resource "azuread_user" "user" {
  for_each = local.user

  user_principal_name   = local.user[each.key].user_principal_name
  display_name          = local.user[each.key].display_name
  account_enabled       = local.user[each.key].account_enabled
  mail_nickname         = each.key
  password              = local.user[each.key].password
  force_password_change = local.user[each.key].force_password_change
  show_in_address_list  = local.user[each.key].show_in_address_list
}

/** Group */
resource "azuread_group" "group" {
  for_each = local.group

  display_name            = each.key
  description             = local.group[each.key].description
  assignable_to_role      = local.group[each.key].assignable_to_role
  members                 = local.group[each.key].members
  owners                  = local.group[each.key].owners
  prevent_duplicate_names = local.group[each.key].prevent_duplicate_names
  security_enabled        = local.group[each.key].security_enabled
  mail_enabled            = local.group[each.key].mail_enabled
}

/** App Registration */
resource "azuread_application" "application" {
  for_each = local.application

  display_name            = each.key
  owners                  = local.application[each.key].owners
  prevent_duplicate_names = local.application[each.key].prevent_duplicate_names
}
/** Application Password */
resource "azuread_application_password" "application_password" {
  for_each = local.application_password

  application_object_id = local.application_password[each.key].application_object_id
  display_name          = local.application_password[each.key].display_name
  end_date              = local.application_password[each.key].end_date
}

/** Service Principal */
resource "azuread_service_principal" "service_principal" {
  for_each = local.service_principal

  application_id               = local.service_principal[each.key].application_id
  account_enabled              = local.service_principal[each.key].account_enabled
  app_role_assignment_required = local.service_principal[each.key].app_role_assignment_required
  description                  = local.service_principal[each.key].description
  owners                       = local.service_principal[each.key].owners
}
/** Service Principal Password*/
resource "azuread_service_principal_password" "service_principal_password" {
  for_each = local.service_principal_password

  service_principal_id = local.service_principal_password[each.key].service_principal_id
  rotate_when_changed  = {
    rotation = local.service_principal_password[each.key].rotation
  }
}

/** Role Assignment*/
resource "azurerm_role_assignment" "role_assignment" {
  for_each = local.role_assignment

  scope                = local.role_assignment[each.key].scope
  role_definition_name = local.role_assignment[each.key].role_definition_name
  principal_id         = local.role_assignment[each.key].principal_id
}
