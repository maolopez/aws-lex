resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

module "lex" {
  source = "../modules/lex"

  region              = local.region
  bot_name            = local.bot_name
  iddle_time          = local.iddle_time
  detect_sentiment    = local.detect_sentiment
}
