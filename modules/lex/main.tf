provider "aws" {
  region = var.region
}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


# Create an intent for ordering flowers
resource "aws_lex_intent" "weather_small_talk" {
  name   = var.bot_name
  region = var.region

  sample_utterances = [
    "It is rainy and cold, I hate it!",
    "It is too hot and humid, I will faint!",
  ]

  slot {
    name     = "WeatherType"
    type     = "WeatherTypeValues"
    required = true
    priority = 1
    value_elicitation_prompt {
      max_attempts = 2
      messages {
        content_type = "PlainText"
        content      = "What kind of weather you like or enjoy?"
      }
    }
  }

  slot {
    description = "The type of weather I like or enjoy"
    name        = "WeatherLike"
    priority    = 2

    sample_utterances = [
      "I love the wheather when it is {WeatherTypeValues}",
      "I don't mind if the weather is {WeatherTypeValues}",
      "I hate when the weather is {WeatherTypeValues}"
    ]
    slot_constrain = "Optional"
  }

  slot {
    name = "WeatherTypeValues"

    enumeration_value {
      value    = "sunny"
      synonyms = ["Sunny", "Clear", "Bright", "Cloudless"]
    }

    enumeration_value {
      value    = "cloudy"
      synonyms = ["Cloudy", "Overcast", "Gloomy"]
    }

    enumeration_value {
      value    = "rainy"
      synonyms = ["Rainy", "Raining", "Showers", "Precipitation"]
    }

    enumeration_value {
      value    = "snowy"
      synonyms = ["Snowy", "Snowing", "Snowfall"]
    }

    enumeration_value {
      value    = "windy"
      synonyms = ["Windy", "Breezy", "Gusty"]
    }

    enumeration_value {
      value    = "foggy"
      synonyms = ["Foggy", "Misty", "Hazy"]
    }

    enumeration_value {
      value    = "stormy"
      synonyms = ["Stormy", "Thunderstorm", "Lightning"]
    }

    enumeration_value {
      value    = "partly_cloudy"
      synonyms = ["Partly Cloudy", "Mostly Cloudy", "Broken Clouds"]
    }
  }

  fulfillment_activity {
    type = "ReturnIntent"
  }

  confirmation_prompt {
    max_attempts = 2
    message {
      content      = "Do you love the weather today?, yes or not"
      content_type = "PlainText"
    }
  }

  follow_up_prompt {
    max_attempts = 2
    message {
      content      = "Do you hate the weather today?, yes or not"
      content_type = "PlainText"
    }

    message {
      content      = "Do you mind the weather today?, yes or not"
      content_type = "PlainText"
    }

    message {
      content      = "Please, describe the weather today"
      content_type = "PlainText"
    }
  }

  rejection_statement {
    message {
      content      = "I feel different about the weather today, bye!"
      content_type = "PlainText"
    }
  }
}

# Create the Lex bot
resource "aws_lex_bot" "weather_small_talk" {
  name   = var.bot_name
  region = var.region

  intent {
    intent_name    = aws_lex_intent.weather_small_talk.name
    intent_version = aws_lex_intent.weather_small_talk.version
  }

  clarification_prompt {
    max_attempts = 2
    messages {
      content_type = "PlainText"
      content      = "Sorry, can you please rephrase with your feeling about the weather today?"
    }
  }

  abort_statement {
    messages {
      content_type = "PlainText"
      content      = "Sorry, I don't have anything to say about that this time."
    }
  }

  child_directed               = false
  description                  = "small talk about the weather and how you feel about it"
  iddle_session_ttl_in_seconds = var.iddle_time
  detect_sentiment             = var.detect_sentiment
}