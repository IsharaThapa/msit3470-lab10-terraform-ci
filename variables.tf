variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy into"
}

variable "name_prefix" {
  type        = string
  default     = "it-8675"
  description = "Name prefix including initials and 4 digits (change if needed)"
}

variable "cidr_vpc" {
  type        = string
  default     = "10.10.0.0/16"
  description = "CIDR block for the VPC"
}

variable "cidr_public_subnet" {
  type        = string
  default     = "10.10.1.0/24"
  description = "CIDR for the public subnet"
}

variable "my_ip_cidr" {
  type        = string
  default     = ""
  description = "Your public IP in CIDR format (e.g. 203.0.113.5/32). Optional; used to lock down SSH if set."
}

variable "http_allowed_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "CIDR allowed for HTTP. Change to your IP (e.g. 203.0.113.5/32) to tighten access as the change management step."
}
