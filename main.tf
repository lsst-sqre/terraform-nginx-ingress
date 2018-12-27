# https://cloud.google.com/community/tutorials/nginx-ingress-gke

resource "kubernetes_namespace" "nginx_ingress" {
  count = "${var.namespace_create ? 1 : 0}"

  metadata {
    name = "${var.namespace}"
  }
}

resource "helm_release" "nginx_ingress" {
  name      = "nginx-ingress"
  chart     = "stable/nginx-ingress"
  namespace = "${kubernetes_namespace.nginx_ingress.metadata.0.name}"
  version   = "1.0.1"

  keyring       = ""
  force_update  = true
  recreate_pods = true

  values = [
    "${data.template_file.nginx_ingress_values.rendered}",
  ]
}

data "template_file" "nginx_ingress_values" {
  template = "${file("${path.module}/charts/nginx-ingress.yaml")}"
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-controller"
    namespace = "${kubernetes_namespace.nginx_ingress.metadata.0.name}"
  }

  depends_on = ["helm_release.nginx_ingress"]
}

locals {
  nginx_ingress_ip = "${lookup(data.kubernetes_service.nginx_ingress.load_balancer_ingress[0], "ip")}"
}
