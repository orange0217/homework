

resource "helm_release" "argo_cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = "$2a$10$.NeEDuo4qmMNzuwHBLMvDuIpvqT52TdzW.1Zg9/dDssaiSRN.xa3u"
  }

  set {
    name  = "configs.params.server.insecure"
    value = "true"
  }

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }

  set_list {
    name  = "server.ingress.hosts"
    value = ["argo.${var.domain}"]
  }
}

resource "helm_release" "crossplane" {

  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = "crossplane-system"
  create_namespace = true
  version    = "1.9.2"
}

resource "helm_release" "ingress-nginx" {
  
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "haproxy" {
  
  name             = "haproxy"
  repository       = "https://haproxytech.github.io/helm-charts"
  chart            = "haproxy"
  namespace        = "haproxy"
  create_namespace = true
}

