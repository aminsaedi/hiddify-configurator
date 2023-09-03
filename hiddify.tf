resource "digitalocean_droplet" "hiddify-machine" {
  image = "ubuntu-20-04-x64"
  name  = "hiddify-machine"
  size  = "s-1vcpu-512mb-10gb"
  region = var.region
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

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "/tmp/install.sh",
    ]
  }

}