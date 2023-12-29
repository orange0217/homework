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

resource "null_resource" "connect_ubuntu" {
  depends_on = [module.k3s]
  connection {
    host     = "${tencentcloud_instance.web[0].public_ip}"
    type     = "ssh"
    user     = "ubuntu"
    password = var.password
  }

  triggers = {
    script_hash = filemd5("${path.module}/init.sh.tpl")
  }

  provisioner "file" {
    destination = "/tmp/init.sh"
    source =  "${path.module}/init.sh.tpl"
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
    source =  "${path.module}/crossplane/crossplane-tf-provider.yaml"

  }

    provisioner "file" {
    destination = "/tmp/crossplane-tf-provider-config.yaml"
    source =  "${path.module}/crossplane/crossplane-tf-provider-config.yaml"

  }

    provisioner "file" {
    destination = "/tmp/application-set.yaml"
    source =  "${path.module}/argocd/application-set.yaml"

  }


  provisioner "file" {
    destination = "/tmp/github-personal-token.yaml"
    content = templatefile(
      "${path.module}/jenkins/github-personal-token.yaml.tpl",
      {
        "github_username" : "${var.github_username}"
        "github_personal_token" : "${var.github_personal_token}"
      }
    )
  }


  provisioner "file" {
    destination = "/tmp/github-pat-secret-text.yaml"
    content = templatefile(
      "${path.module}/jenkins/github-pat-secret-text.yaml.tpl",
      {
        "github_personal_token" : "${var.github_personal_token}"
      }
    )
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "sh /tmp/init.sh",
    ]
  }
}