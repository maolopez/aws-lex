variable "region" {
  type        = string
  description = "default region"
}

variable "bot_name" {
  type        = string
  description = "The unique bot name"
}

variable "lex_bot_role" {
  type        = string
  description = "The role for using with the bot"
}

variable "lex_bot_policy" {
  type        = string
  description = "The policy to use with the bot's role"
}

variable "slot_type_name" {
  type        = string
  description = "bot's slot type name"
}