variable "region" {
  type        = string
  description = "region where the resources will be created"
}

variable "project" {
  type        = string
  description = "project code to be used for resources naming"
}

variable "sns_email_list" {
  type = map
  description = "list of emails to subscribe to sns topic for guardduty findings notifications"
}

variable "account_id" {
  type        = string
  description = "account id for allowing sns topic policy"
}