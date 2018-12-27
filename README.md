deploy nginx "ingress" controller to a kubernetes cluster
===

[![Build Status](https://travis-ci.org/lsst-sqre/terraform-nginx-ingress.png)](https://travis-ci.org/lsst-sqre/terraform-nginx-ingress)

Usage
---

```bash
module "nginx_ingress" {
  source    = "git::https://github.com/lsst-sqre/terraform-nginx-ingress.git//?ref=master"

  namespace        = "nginx-ingress" # default
  namespace_create = true
}
```

See Also
---

* [`terraform`](https://www.terraform.io/)
* [`nginx-ingress`](https://github.com/kubernetes/ingress-nginx)
