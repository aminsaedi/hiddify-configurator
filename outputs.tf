output "ipv4_address" {
  value = digitalocean_droplet.hiddify-machine.ipv4_address
  description = "Your VPN server main ip address - (set your domain A record to this address)"
}