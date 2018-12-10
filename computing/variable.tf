variable "aws_server_size" {}
variable "server_sg_id" {}
variable "service_port" {}
variable "subnet1_id" {}
variable "subnet2_id" {}
variable "vpc_id" {}


variable "healthcheck_path" {
  type        = "string"
  default = "/v1/healthcheck"
  description = "Path to health check"
}

output "server-dns" {
  value = "${aws_alb.server_lb.dns_name}"
}

output "lb_helathcheck" {
  value = "${aws_alb_target_group.lb_targets.health_check}"
}
