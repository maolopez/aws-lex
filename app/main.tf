resource "random_string" "suffix" {
  length  = 4
  numeric = false
  special = false
  upper   = false
}

module "lex" {
  source = "../modules/lex"

  region         = local.region
  bot_name       = local.bot_name
  lex_bot_role   = local.lex_bot_role
  lex_bot_policy = local.lex_bot_policy
  slot_type_name = local.slot_type_name
}
