resource "digitalocean_droplet" "hiddify-machine" {
  image = "ubuntu-20-04-x64"
  name  = "hiddify-machine"
  size  = "s-1vcpu-512mb-10gb"
  # region = var.region
  ssh_keys = [
    data.digitalocean_ssh_key.amin_pop_os.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "15m"
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/install.sh",
  #     "/tmp/install.sh",
  #   ]
  # }

}

resource "cloudflare_record" "domain_direct" {
  zone_id = var.cloudflare_zone_id
  name = format("direct-%s",digitalocean_droplet.hiddify-machine.region)
  value = digitalocean_droplet.hiddify-machine.ipv4_address
  type = "A"
  proxied = false
}

resource "cloudflare_record" "domain_cdn" {
  zone_id = var.cloudflare_zone_id
  name = format("cloud-%s",digitalocean_droplet.hiddify-machine.region)
  value = digitalocean_droplet.hiddify-machine.ipv4_address
  type = "A"
  proxied = true
}

resource "cloudflare_record" "domain_cdn_auto" {
  zone_id = var.cloudflare_zone_id
  name = format("cloud-auto-%s",digitalocean_droplet.hiddify-machine.region)
  value = digitalocean_droplet.hiddify-machine.ipv4_address
  type = "A"
  proxied = true
}
