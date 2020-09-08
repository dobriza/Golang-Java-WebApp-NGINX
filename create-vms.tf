# # # --------------------------------------------------------------------------------------------------
# # # Create vms at Digital Ocean-----------------------------------------------------------------------
# # # --------------------------------------------------------------------------------------------------

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

# create SSH key
resource "digitalocean_ssh_key" "key" {
  name       = "dobrizaKey-Dev02"
  public_key = file("./dev02.pub")
}

variable "vm_nginx_web_app" {
  type        = list(string)
  default     = ["nginx-webapps01"]
  description = "vm for java/golang web app"

}

# Create vms 

resource "digitalocean_droplet" "webapp" {
  count    = length(var.vm_nginx_web_app)
  image    = "debian-9-x64"
  ssh_keys = [digitalocean_ssh_key.key.id]
  name     = var.vm_nginx_web_app[count.index]
  size     = "s-1vcpu-1gb"
  region   = "nyc1"
  tags     = ["dev02", "dobriza_yandex_ru"]
}


# # # --------------------------------------------------------------------------------------------------
# # # -------AWS Route53 configuration------------------------------------------------------------------
# # # --------------------------------------------------------------------------------------------------

# Declare variables that stores access keys 

variable "access_key" {}
variable "secret_key" {}

# Configure the AWS Provider

provider "aws" {
  version    = "~> 2.0"
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Fetch data from route53

data "aws_route53_zone" "devops" {
  name = "devops.rebrain.srwx.net."
}

# Create DNS A records at devops.rebrain.srwx.net. zone

resource "aws_route53_record" "nginxWebApp" {
  zone_id = data.aws_route53_zone.devops.zone_id
  count   = length(digitalocean_droplet.webapp)
  name    = digitalocean_droplet.webapp[count.index].name
  type    = "A"
  ttl     = "300"
  records = [digitalocean_droplet.webapp[count.index].ipv4_address]
}

locals {
  nginxWebApp     = aws_route53_record.nginxWebApp.*.name
  domainSuffix = data.aws_route53_zone.devops.name
}

