output "ipv4_address" {
  value = digitalocean_droplet.hiddify-machine.ipv4_address
  description = "Your VPN server main ip address - (set your domain A record to this address)"
}

output "direct-fqdn" {
  value = cloudflare_record.domain_direct.hostname
  description = "The FQDN directly pointing to the created droplet. (used by ansible to configure vpn)"
}
