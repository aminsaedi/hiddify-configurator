variable "do_token" {
  description = "My Digital ocean token"
  type        = string
}
variable "pvt_key" {
  description = "My Digital ocean Private Key Location"
  type        = string
}
variable "region" {
  description = "The region that you want to create your droplet"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Your cloudflare api token with write access to your target zone"
  type = string
}

variable "cloudflare_zone_id" {
  description = "Your cloudflare zone id"
  type = string
}
