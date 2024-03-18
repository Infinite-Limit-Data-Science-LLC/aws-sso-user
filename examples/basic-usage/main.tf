resource "random_pet" "name_suffix" {
  length                = 2
}

locals {
  name_suffix           = random_pet.name_suffix.id
  display_name          = "${var.name} ${local.name_suffix}"
  username              = "${var.name}-${local.name_suffix}"
}

data "aws_ssoadmin_instances" "sso_instances" {}

module "sso_user1" {
  source                = "../../modules"
  identity_store_id     = tolist(data.aws_ssoadmin_instances.sso_instances.identity_store_ids)[0]
  display_name          = local.display_name
  user_name             = local.username
  given_name            = local.display_name
  family_name           = local.username
}