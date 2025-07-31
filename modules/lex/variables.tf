variable "region" {
  type        = string
  description = "default region"
}

variable "bot_name" {
  type        = string
  description = "The unique bot name"
}

variable "iddle_time" {
  type        = number
  description = "Time in seconds to retain the data gathered in a conversation. Between 60 and 86400"
}

variable "detect_sentiment" {
  type        = bool
  description = "To detect sentiment will hook to Comprehend AWS pre-trained models"
}