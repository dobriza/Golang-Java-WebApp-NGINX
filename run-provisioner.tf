
resource "null_resource" "ansible_playbook_run_on_nginx_host" {
  depends_on = [local_file.ansible_cfg_file]
  count      = length(var.vm_nginx_web_app)
  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("./dev02")
      host        = digitalocean_droplet.webapp[count.index].ipv4_address
    }
  }
  provisioner "local-exec" {
    command = "export ANSIBLE_CONFIG=./ansible.cfg && time ansible-playbook -c paramiko install_nginx.yml -vvv"
  }
}


