provider "aws" {
  region = var.primary_region
}

# provider "aws" {
#   alias  = "secondary_region"
#   region = var.secondary_region
# }