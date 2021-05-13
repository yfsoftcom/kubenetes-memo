provider "kubernetes" {
  config_path    = "~/.kube/config_local"
  config_context = "microk8s"
}

resource "kubernetes_namespace" "fpm" {
  metadata {
    name = "fpm"
  }
}