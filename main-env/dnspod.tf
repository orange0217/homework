resource "tencentcloud_dnspod_record" "jenkins" {
  domain      = var.domain
  record_type = "A"
  record_line = "默认"
  value       = module.cvm.public_ip
  sub_domain  = "jenkins"
}

resource "tencentcloud_dnspod_record" "argocd" {
  domain      = var.domain
  record_type = "A"
  record_line = "默认"
  value       = module.cvm.public_ip
  sub_domain  = "argo"
}

resource "tencentcloud_dnspod_record" "bookinfo" {
  domain      = var.domain
  record_type = "A"
  record_line = "默认"
  value       = module.cvm.public_ip
  sub_domain  = "bookinfo"
}