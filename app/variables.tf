locals {
  random_suffix = "${substr("abcdefghijklmnopqrstuvwxyz", 0, 1)}${random_string.suffix.result}"
  region              = "us-east-1"
  awsaccount          = "271271282869"
  bot_name            = "weather_small_talk_${local.random_suffix}"
  iddle_time          = 600
  detect_sentiment    = true

}
