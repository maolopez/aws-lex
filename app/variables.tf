locals {
  region              = "us-east-1"
  awsaccount          = "271271282869"
  bucket_name_samples = "bucket-samples-${random_string.suffix.result}"
  bot_name            = "weather_small_talk_${random_string.suffix.result}"
  iddle_time          = 600
  detect_sentiment    = true

}
