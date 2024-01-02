#resource "local_sensitive_file" "kubeconfig" {
#  content  = module.k3s.kube_config
#  filename = "${path.module}/config.yaml"
#}


output "kube_config" {
  value = module.k3s.kube_config
}

output "kubernetes" {
  value = module.k3s.kubernetes
}
