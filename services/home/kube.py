from kubernetes import client, config
from typing import Dict
from kubernetes import client, config


def get_stats() -> Dict[str, int]:
    """
    Retrieve statistics for each Kubernetes resource type.

    Returns:
        A dictionary with the statistics.
    """
    # Load the Kubernetes configuration from default location
    config.load_incluster_config()

    # Create API clients for each Kubernetes resource type
    api = client.CoreV1Api()
    apps_api = client.AppsV1Api()
    batch_api = client.BatchV1Api()
    networking_api = client.NetworkingV1Api()

    # Retrieve the statistics for each resource type
    pods = api.list_pod_for_all_namespaces().items
    deployments = apps_api.list_deployment_for_all_namespaces().items
    cronjobs = batch_api.list_cron_job_for_all_namespaces().items
    ingresses = networking_api.list_ingress_for_all_namespaces().items
    pvcs = api.list_persistent_volume_claim_for_all_namespaces().items
    nodes = api.list_node().items
    namespaces = api.list_namespace().items
    services = api.list_service_for_all_namespaces().items

    # Create a dictionary with the statistics
    return {
        "pods": len(pods),
        "deployments": len(deployments),
        "cronjobs": len(cronjobs),
        "ingresses": len(ingresses),
        "pvcs": len(pvcs),
        "nodes": len(nodes),
        "namespaces": len(namespaces),
        "services": len(services),
    }
