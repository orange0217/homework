resource "tencentcloud_dnspod_record" "bluegreen" {
  domain      = var.domain
  record_type = "A"
  record_line = "默认"
  value       = module.cvm.public_ip
  sub_domain  = "bluegreen"
}

resource "tencentcloud_dnspod_record" "canary" {
  domain      = var.domain
  record_type = "A"
  record_line = "默认"
  value       = module.cvm.public_ip
  sub_domain  = "canary"
}

