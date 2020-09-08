resource "local_file" "ansible_cfg_file" {
  depends_on = [local_file.inventory]
  filename  = "ansible.cfg"
  content   = <<-EOF
[defaults]
inventory = ./hosts.ini
host_key_checking = False
remote_tmp = ~/.ansible/tmp
remote_user = root
retry_files_enabled = True
retry_files_save_path = ./
  EOF
}



resource "local_file" "inventory" {
  filename = "hosts.ini"
  content  = <<-EOT
[nginx]
%{for name in local.nginxWebApp~}
${name}.${local.domainSuffix}
%{endfor~}

[nginx:vars]
ansible_user = root
ansible_ssh_private_key_file = ./dev02
  EOT
}





