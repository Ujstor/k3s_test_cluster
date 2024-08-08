module "kube_hetzner" {
  source = "github.com/kube-hetzner/terraform-hcloud-kube-hetzner?ref=v2.14.1"

  providers = {
    hcloud = hcloud
  }

  hcloud_token = var.hcloud_token

  ssh_public_key  = file("${var.ssh_key_path}/${var.ssh_key_name}.pub")
  ssh_private_key = file("${var.ssh_key_path}/${var.ssh_key_name}")
  network_region  = "eu-central"

  control_plane_nodepools = [
    {
      name        = "cp-fsn1",
      server_type = "cx22",
      location    = "fsn1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "cp-nbg1",
      server_type = "cx22",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "cp-hel1",
      server_type = "cx22",
      location    = "hel1",
      labels      = [],
      taints      = [],
      count       = 1
    }
  ]

  agent_nodepools = [
    {
      name        = "agent-1",
      server_type = "cx32",
      location    = "fsn1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "agent-2",
      server_type = "cx32",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "agent-3",
      server_type = "cx32",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 1
    },
  ]

  load_balancer_type           = "lb11"
  load_balancer_location       = "fsn1"
  load_balancer_disable_ipv6   = true
  load_balancer_algorithm_type = "least_connections"

  ingress_controller  = "nginx"
  enable_cert_manager = true
}

module "cloudflare_record" {
  source = "github.com/Ujstor/self-hosting-infrastructure-cluster//modules/modules/network/cloudflare_record?ref=v0.0.1"

  cloudflare_record = {
    gitlab = {
      zone_id = var.cloudflare_zone_id
      name    = "gitlab"
      value   = module.kube_hetzner.ingress_public_ipv4
      type    = "A"
      ttl     = 3600
      proxied = false
    }
    kas = {
      zone_id = var.cloudflare_zone_id
      name    = "kas"
      value   = module.kube_hetzner.ingress_public_ipv4
      type    = "A"
      ttl     = 3600
      proxied = false
    }
    minio = {
      zone_id = var.cloudflare_zone_id
      name    = "minio"
      value   = module.kube_hetzner.ingress_public_ipv4
      type    = "A"
      ttl     = 3600
      proxied = false
    }
    registry = {
      zone_id = var.cloudflare_zone_id
      name    = "registry"
      value   = module.kube_hetzner.ingress_public_ipv4
      type    = "A"
      ttl     = 3600
      proxied = false
    }
  }
  depends_on = [module.kube_hetzner]
}
