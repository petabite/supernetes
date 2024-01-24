resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name = "cloudflare-api-token"
    namespace = "kube-system"
  }

  data = {
    token = var.cloudflare_api_token
  }
}

resource "kubernetes_secret" "tls_certificate" {
    metadata {
        name = "tls-certificate"
        namespace = "kube-system"
    }

    data = {
        "tls.crt" = file("${path.module}/secrets/tls.crt")
        "tls.key" = file("${path.module}/secrets/tls.key")
    }
}
