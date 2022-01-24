variable "name" {
  description = "Name of the API gateway deployment"
  type        = string
}

variable "definition" {
  description = "Definition of the API Gateway"
  type        = string
}

variable "stage" {
  description = "Name of the stage to which deployed"
  type        = string
}

variable "domain_name" {
  default     = ""
  description = "Custom domain name"
  type        = string
}

