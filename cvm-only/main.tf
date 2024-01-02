module "cvm" {
  source     = "../modules/cvm"
  secret_id  = var.secret_id
  secret_key = var.secret_key
  password   = var.password
}




resource "null_resource" "connect_ubuntu" {
  connection {
    host     = module.cvm.public_ip
    type     = "ssh"
    user     = "ubuntu"
    password = var.password
  }



  provisioner "remote-exec" {
    inline = [
      "wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg",
      "echo deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main | sudo tee /etc/apt/sources.list.d/hashicorp.list",
      "sudo apt update && sudo apt install terraform",
    ]
  }
}
