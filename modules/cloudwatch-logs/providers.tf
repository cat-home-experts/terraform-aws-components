provider "aws" {
  region = var.region

  # `terraform import` will not use data from a data source, so on import we have to explicitly specify the profile
  profile = coalesce(var.import_profile_name, module.iam_roles.terraform_profile_name)

  # See issue: https://github.com/hashicorp/terraform-provider-aws/issues/18311
  # default_tags {
  #   tags = module.this.tags
  # }
}

module "iam_roles" {
  source  = "../account-map/modules/iam-roles"
  context = module.this.context
}

variable "import_profile_name" {
  type        = string
  default     = null
  description = "IAM Profile to use when importing a resource"
}
