variable "aws_vpc_name" {
  type        = "string"
  description = "The AWS VPC name"
}

variable "aws_region" {
  type = "string"
}

variable "aws_zone" {
  type = "string"
}

variable "aws_server_size" {
  type        = "string"
  description = "AWS instance sizing for the server"
}

variable "service_port" {
  type        = "string"
  description = "Web Server default port"
}

// Output variables

output "Server-DNS" {
  value = "${module.computing.server-dns}"
}

output "VPC-id" {
  value = "${module.networking.vpc_id}"
}

output "Healthcheck" {
  value = "${module.computing.lb_helathcheck}"
}
