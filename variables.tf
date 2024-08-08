variable "hcloud_token" {
  description = "HCloud API read/write token"
  type        = string
  sensitive   = true
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone id"
  type        = string
}

variable "ssh_key_name" {
  type        = string
  description = "Name of the SSH key created and used for Hetzner cloud and serves"
  default     = "test_k3s_cluster"
}

variable "ssh_key_path" {
  description = "Path where the SSH key is stored"
  type        = string
  default     = "~/.ssh"
}
