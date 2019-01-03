deploy nginx "ingress" controller to a kubernetes cluster
===

[![Build Status](https://travis-ci.org/lsst-sqre/terraform-nginx-ingress.png)](https://travis-ci.org/lsst-sqre/terraform-nginx-ingress)

Usage
---

```terraform
provider "kubernetes" {
  version = "~> 1.4.0"

  load_config_file = true

  host                   = "${module.gke.host}"
  cluster_ca_certificate = "${base64decode(module.gke.cluster_ca_certificate)}"
}

module "tiller" {
  source = "git::https://github.com/lsst-sqre/terraform-tinfoil-tiller.git//?ref=master"

  namespace       = "kube-system"
  service_account = "tiller"
}

provider "helm" {
  version = "~> 0.6.2"

  service_account = "${module.tiller.service_account}"
  namespace       = "${module.tiller.namespace}"
  install_tiller  = false

  kubernetes {
    host                   = "${module.gke.host}"
    cluster_ca_certificate = "${base64decode(module.gke.cluster_ca_certificate)}"
  }
}

module "nginx_ingress" {
  source = "git::https://github.com/lsst-sqre/terraform-nginx-ingress.git//?ref=master"

  chart_version    = "1.0.1" # default
  namespace        = "nginx-ingress" # default
  namespace_create = true
}

output "ingress_ip" {
  value = "${module.nginx_ingress.ingress_ip}"
}
```

See Also
---

* [`terraform`](https://www.terraform.io/)
* [`nginx-ingress`](https://github.com/kubernetes/ingress-nginx)
