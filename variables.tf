variable "name" {
  default = null
}

variable "max_session_duration" {
  default = null
}

variable "assume_role_policy_statement" {
  type = list(any)
}

variable "policy_statement" {
  type     = list(any)
  default  = []
  nullable = false
}

variable "policy_arns" {
  type     = list(string)
  default  = []
  nullable = false
}