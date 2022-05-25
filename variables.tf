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
      name            = ""
      content_type    = null
      not_before_date = null
      expiration_date = null
    }
    user = {
      account_enabled             = true
      age_group                   = null
      business_phones             = null
      city                        = null
      company_name                = null
      consent_provided_for_minor  = null
      cost_center                 = null
      country                     = null
      department                  = null
      disable_password_expiration = false
      disable_strong_password     = false
      display_name                = ""
      division                    = null
      employee_id                 = null
      employee_type               = null
      fax_number                  = null
      force_password_change       = true
      given_name                  = null
      job_title                   = null
      mail                        = null
      mail_nickname               = null
      manager_id                  = null
      mobile_phone                = null
      office_location             = null
      onpremises_immutable_id     = null
      other_mails                 = null
      password                    = "change_IT#9"
      postal_code                 = null
      preferred_language          = null
      show_in_address_list        = false
      state                       = null
      street_address              = null
      surname                     = null
      usage_location              = null
    }
    group = {
      assignable_to_role         = false
      auto_subscribe_new_members = null
      behaviors                  = null
      description                = null
      display_name               = ""
      external_senders_allowed   = null
      hide_from_address_lists    = null
      hide_from_outlook_clients  = null
      mail_enabled               = false
      mail_nickname              = null
      members                    = []
      owners                     = null
      prevent_duplicate_names    = true
      provisioning_options       = null
      security_enabled           = true
      theme                      = null
      types                      = null
      visibility                 = null
      dynamic_membership = {
        enabled = true
        rule    = ""
      }
    }
    application = {
      device_only_auth_enabled       = false
      display_name                   = ""
      fallback_public_client_enabled = false
      group_membership_claims        = null
      identifier_uris                = []
      logo_image                     = null
      marketing_url                  = null
      oauth2_post_response_required  = null
      owners                         = null
      prevent_duplicate_names        = true
      privacy_statement_url          = null
      sign_in_audience               = null
      support_url                    = null
      template_id                    = null
      terms_of_service_url           = null
      api                            = {}
      app_role                       = {}
      feature_tags                   = {}
      optional_claims                = {}
      public_client                  = {}
      required_resource_access       = {}
      single_page_application        = {}
      web                            = {}
      tags                           = {}
    }
    application_password = {
      display_name        = ""
      end_date            = null
      end_date_relative   = null
      rotate_when_changed = null
      start_date          = null
    }
    service_principal = {
      account_enabled               = true
      alternative_names             = null
      app_role_assignment_required  = false
      description                   = ""
      login_url                     = null
      notes                         = null
      notification_email_addresses  = null
      owners                        = null
      preferred_single_sign_on_mode = null
      use_existing                  = null
      feature_tags = {
        custom_single_sign_on = false
        enterprise            = false
        gallery               = false
        hide                  = false
      }
      saml_single_sign_on = {
        relay_state = null
      }
      tags = {}
    }
    service_principal_password = {
      display_name        = ""
      end_date            = null
      end_date_relative   = null
      rotate_when_changed = null
      start_date          = null
    }
    role_assignment = {
      name                                   = null
      role_definition_name                   = null
      role_definition_id                     = null
      condition                              = null
      condition_version                      = null
      delegated_managed_identity_resource_id = null
      description                            = null
      skip_service_principal_aad_check       = null
    }
  }

  # compare and merge custom and default values
  group_values = {
    for group in keys(var.group) :
    group => merge(local.default.group, var.group[group])
  }
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
    group => merge(
      local.group_values[group],
      {
        for config in ["dynamic_membership"] :
        config => merge(local.default.group[config], local.group_values[group][config])
      }
    )
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
