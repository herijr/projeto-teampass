variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "default"
}

variable "project-name" {
  type        = string
  description = ""
  default     = "teampass"
}

variable "ec2_key_name" {
  type        = string
  description = ""
  default     = "aws01"
}