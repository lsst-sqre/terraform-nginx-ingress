variable "namespace" {
  description = "kubernetes namespace to install into."
  default     = "nginx-ingress"
}

variable "namespace_create" {
  description = "create kubernetes namespace."
  default     = false
}

variable "chart_version" {
  description = "version of helm stable/nginx-ingress chart."
  default     = "1.0.1"
}
