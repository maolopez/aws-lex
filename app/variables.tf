locals {
  random_suffix  = "${substr("abcdefghijklmnopqrstuvwxyz", 0, 1)}${random_string.suffix.result}"
  region         = "us-east-1"
  awsaccount     = "271271282869"
  bot_name       = "WeatherSmallTalk_${local.random_suffix}" #expected value of name to match regular expression "^([A-Za-z]_?)+$"
  lex_bot_role   = "lbrole-${random_string.suffix.result}"
  lex_bot_policy = "lbpolicy-${random_string.suffix.result}"
  slot_type_name = "stweather_${local.random_suffix}"
  ttl            = 300
}
