module "cvm" {
  source     = "../modules/cvm"
  secret_id  = var.secret_id
  secret_key = var.secret_key
  password   = var.password
}

module "k3s" {
  source     = "../modules/k3s"
  public_ip  = module.cvm.public_ip
  private_ip = module.cvm.private_ip
}

resource "local_sensitive_file" "kubeconfig" {
  content  = module.k3s.kube_config
  filename = "${path.module}/config.yaml"
}

resource "null_resource" "connect_ubuntu" {
  depends_on = [module.k3s,helm_release.cert-manager,helm_release.argocd,helm_release.crossplane]
  connection {
    host     = module.cvm.public_ip
    type     = "ssh"
    user     = "ubuntu"
    password = var.password
  }

  triggers = {
    script_hash = filemd5("${path.module}/init.sh.tpl")
  }

  provisioner "file" {
    destination = "/tmp/init.sh"
    content = templatefile(
      "${path.module}/init.sh.tpl",
      {
        "domain" : "${var.domain}"
        "jenkins_password" : "${var.password}"
        "argocd_password"  : var.password
      }
    )
  }

  provisioner "file" {
    destination = "/tmp/dnspod-webhook-values.yaml"
    content = templatefile(
      "${path.module}/cert-manager-webhook-dnspod/dnspod-webhook-values.yaml.tpl",
      {
        "apiID" : "${var.apiID}"
        "apiToken" : "${var.apiToken}"
      }
    )
  }

  provisioner "file" {
    destination = "/tmp/argocd-cert.yaml"
    source      = "${path.module}/cert-manager-webhook-dnspod/argocd-cert.yaml"
  }


  provisioner "file" {
    destination = "/tmp/argocd-ingress.yaml"
    source      = "${path.module}/argocd/argocd-ingress.yaml"
  }

    provisioner "file" {
    destination = "/tmp/jenkins-ingress.yaml"
    source      = "${path.module}/jenkins/jenkins-ingress.yaml"
  }

  provisioner "file" {
    destination = "/tmp/jenkins-service-account.yaml"
    source      = "${path.module}/jenkins/jenkins-service-account.yaml"
  }

  provisioner "file" {
    destination = "/tmp/jenkins-values.yaml"
    source =  "${path.module}/jenkins/values.yaml.tpl"

  }

    provisioner "file" {
    destination = "/tmp/crossplane-tf-provider.yaml"
    source =  "${path.module}/crossplane1/crossplane-tf-provider.yaml"

  }

    provisioner "file" {
    destination = "/tmp/crossplane-tf-provider-config.yaml"
    source =  "${path.module}/crossplane1/crossplane-tf-provider-config.yaml"

  }

    provisioner "file" {
    destination = "/tmp/application-set.yaml"
    source =  "${path.module}/argocd/application-set.yaml"

  }

    provisioner "file" {
    destination = "/tmp/haproxy-ingress.yaml"
    source =  "${path.module}/haproxy1/haproxy-ingress.yaml"

  }


  provisioner "file" {
    destination = "/tmp/github-personal-token.yaml"
    content = templatefile(
      "${path.module}/jenkins/github-personal-token.yaml.tpl",
      {
        "github_personal_token" : "${var.github_personal_token}"
      }
    )
  }


  provisioner "file" {
    destination = "/tmp/github-user-pass.yaml"
    content = templatefile(
      "${path.module}/jenkins/github-user-pass.yaml.tpl",
      {
        "github_username" : "${var.github_username}"
        "github_personal_token" : "${var.github_personal_token}"
      }
    )
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "sudo apt install dos2unix",
      "dos2unix /tmp/init.sh",
      "sh /tmp/init.sh",
    ]
  }
}