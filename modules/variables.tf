# variable "name_prefix" {
#   type          = string
#   description   = "name prefix"
# }

# variable "name_suffix" {
#   type          = string
#   description   = "name suffix"
# }

variable "primary_region" {
  type          = string
  description   = "primary region"
  default       = "us-east-1"
}

# variable "secondary_region" {
#   type          = string
#   description   = "secondary region"
#   default       = "us-west-2"
# }

variable "identity_store_id" {
  type          = string
  description   = "identity store id"
}

variable "display_name" {
  type          = string
  description   = "name prefix"
}

variable "user_name" {
  type          = string
  description   = "user_name"
}

variable "given_name" {
  type          = string
  description   = "given name"
}

variable "family_name" {
  type          = string
  description   = "family name"
}

variable "email" {
  type          = string
  description   = "email"
  default       = null
}

# variable "replication_enabled" {
#   type          = bool
#   description   = "replication enabled"
# }

# variable "tags" {
#   type          = map(string)
#   description   = "tags"
#   default       = {}
# }