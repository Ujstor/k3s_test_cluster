output "kubeconfig" {
  value     = module.kube_hetzner.kubeconfig
  sensitive = true
}

output "lb_ip" {
  value = module.kube_hetzner.ingress_public_ipv4
}

