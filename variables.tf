variable "namespace" {
  description = "kubernetes namespace to install into."
  default     = "nginx-ingress"
}

variable "namespace_create" {
  description = "create kubernetes namespace."
  default     = false
}
