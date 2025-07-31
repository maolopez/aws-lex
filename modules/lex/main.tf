provider "aws" {
  region = var.region
}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_lexv2models_bot" "weather_small_talk" {
  region                      = var.region
  name                        = var.bot_name
  description                 = "small talk about the weather and how you feel about it"
  role_arn                    = aws_iam_role.lex_bot.arn
  idle_session_ttl_in_seconds = var.ttl
  data_privacy {
    child_directed = false
  }
}

resource "aws_lexv2models_bot_locale" "weather_small_talk_locale" {
  region                           = var.region
  bot_id                           = aws_lexv2models_bot.weather_small_talk.id
  locale_id                        = "en_US"
  n_lu_intent_confidence_threshold = 0.4
  bot_version                      = "DRAFT"
}

resource "aws_lexv2models_intent" "weather_small_talk_intent" {
  region      = var.region
  name        = var.bot_name
  description = "Weather small talk intent"
  bot_id      = aws_lexv2models_bot.weather_small_talk.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.weather_small_talk_locale.locale_id
  closing_setting {
    active = true
    closing_response {
      message {
        plain_text_message {
          value = "Sorry, I don't have anything to say about that this time."
        }
      }
    }
  }

  initial_response_setting {
    initial_response {
      message_group {
        message {
          plain_text_message {
            value = "Do you love or hate the weather today?"
          }
        }
      }
    }
  }

  sample_utterance {
    utterance = "I want to talk about the weather today"
    slot_priority {
      priority = 1
      slot_id  = "first" #unique
    }
  }

}

resource "aws_lexv2models_slot" "weather_type_slot" {
  region        = var.region
  name          = var.slot_type_name
  description   = "The type of weather"
  bot_id        = aws_lexv2models_bot.weather_small_talk.id
  bot_version   = "DRAFT"
  bot_locale_id = aws_lexv2models_bot_locale.weather_small_talk_locale.locale_id
  intent_id     = aws_lexv2models_intent.weather_small_talk_intent.id
  slot_type_id  = aws_lexv2models_slot_type.weather_type.id
  value_elicitation_setting {
    prompt {
      message_groups {
        message {
          plain_text_message {
            value = "What kind of weather you like or enjoy?"
          }
        }
      }
    }
  }
}

resource "aws_lexv2models_slot_type" "weather_type" {
  region      = var.region
  name        = var.slot_type_name
  description = "Values for weather type"
  bot_id      = aws_lexv2models_bot.weather_small_talk.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.weather_small_talk_locale.locale_id
  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}