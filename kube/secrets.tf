resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = "kube-system"
  }

  data = {
    token = var.cloudflare_api_token
  }
}

resource "kubernetes_secret" "tls_certificate" {
  metadata {
    name      = "tls-certificate"
    namespace = "kube-system"
  }

  data = {
    "tls.crt" = file("${path.module}/secrets/tls.crt")
    "tls.key" = file("${path.module}/secrets/tls.key")
  }
}

resource "kubernetes_secret" "prometheus-auth-secret" {
  metadata {
    name      = "prometheus-auth-secret"
    namespace = "monitoring"
  }

  data = {
    users = file("${path.module}/secrets/prometheus-auth")
  }
}
resource "kubernetes_secret" "alertmanager-auth-secret" {
  metadata {
    name      = "alertmanager-auth-secret"
    namespace = "monitoring"
  }

  data = {
    users = file("${path.module}/secrets/alertmanager-auth")
  }
}

resource "kubernetes_secret" "traefik-auth-secret" {
  metadata {
    name      = "traefik-auth-secret"
    namespace = "kube-system"
  }

  data = {
    users = file("${path.module}/secrets/traefik-auth")
  }
}

