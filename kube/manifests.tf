data "kubectl_path_documents" "manifests" {
  pattern = "./manifests/*.yaml"
}

data "kubectl_path_documents" "nested_manifests" {
  pattern = "./manifests/**/*.yaml"
}

resource "kubectl_manifest" "manifests" {
  for_each  = data.kubectl_path_documents.manifests.manifests
  yaml_body = each.value
}


resource "kubectl_manifest" "nested_manifests" {
  for_each  = data.kubectl_path_documents.nested_manifests.manifests
  yaml_body = each.value
}
