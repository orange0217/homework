# Create security group with 4 rules
resource "tencentcloud_security_group" "web_sg" {
  name        = "web-sg"
  description = "make it accessible for both production and stage ports"
}

# be careful with the security group, we let all port open for demo purpose
resource "tencentcloud_security_group_rule" "all" {
  security_group_id = tencentcloud_security_group.web_sg.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  policy            = "accept"
}


resource "tencentcloud_security_group_rule" "web_egrees_any" {
  security_group_id = tencentcloud_security_group.web_sg.id
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  policy            = "accept"
}
