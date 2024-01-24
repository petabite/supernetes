resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces
  metadata {
    name = each.value
  }
}

resource "kubernetes_secret" "namespace_pull_secrets" {
  for_each = var.namespaces
  metadata {
    name = "container-registry"
    namespace = each.value
  }

  data = {
    ".dockerconfigjson" = "${file("${path.module}/secrets/docker-config.json")}"
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_default_service_account" "namespace_default_service_accounts" {
  for_each = var.namespaces
  metadata {
    namespace = each.value
  }

  image_pull_secret {
    name = "container-registry"
  }
}
