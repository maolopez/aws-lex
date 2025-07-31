resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

module "lex" {
  source = "../modules/lex"

  region              = local.region
  bucket_name_samples = local.bucket_name_samples
  bot_name            = local.bot_name
  iddle_time          = local.iddle_time
  detect_sentiment    = local.detect_sentiment
}
