data "kubectl_path_documents" "manifests" {
    pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "manifests" {
    for_each  = toset(data.kubectl_path_documents.manifests.documents)
    yaml_body = each.value
}
