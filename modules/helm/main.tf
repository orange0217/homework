provider "helm" {
  kubernetes {
    config_path = local_sensitive_file.kubeconfig.filename
  }
}

resource "helm_release" "argo_cd" {
  depends_on       = [module.k3s]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}

resource "helm_release" "crossplane" {
  depends_on       = [module.k3s]
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  namespace        = "crossplane-system"
  create_namespace = true
}

resource "helm_release" "ingress-nginx" {
  depends_on       = [module.k3s]
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "haproxy" {
  depends_on       = [module.k3s]
  name             = "haproxy"
  repository       = "https://haproxytech.github.io/helm-charts"
  chart            = "haproxy"
  namespace        = "haproxy"
  create_namespace = true
}

