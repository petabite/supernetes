<h1 align="center">supernetes</h1>
<p align="center" style="font-weight: bold;">A Kubernetes cluster up in the cloud</p>

<p align="center">
    <img style="align: center;" width="250" src="https://raw.githubusercontent.com/petabite/supernetes/main/services/home/static/img/supernetes.png"/>
</p>

## What is this?

With the [sunset of Heroku's free tier](https://blog.heroku.com/next-chapter) for its hosting services in November 2022, many of my projects
were sadly left for dead and no longer had a publicly accessible endpoint. After considering countless other cost-free offerings to migrate to, I asked myself: "Why don't you just do your own infra?"

So, I provisioned a VM in the cloud, installed Kubernetes on it, dockerized my projects, and deployed them to the new cluster. Since I was building my own
solution, it came with the benefit of not being limited by the constraints of Heroku's free tier. For example, I can
have databases
that are as large as I want (no more 10k row limit). I can enjoy immediate responses from my containers (no more waiting for cold starts after sleeping due to inactivity).
I can also host any workload I want without being limited by Heroku's supported runtimes. The cherry on top is that this solution is still cost-free since I'm using Oracle Cloud Infrastructure's free tier! (well, unless Oracle decides to pull the plug on that too 😅 \*\*knock on wood\*\*)

This repo contains the Terraform for the Kubernetes cluster itself as well as the source for the core services that run on the cluster.

## Infrastructure

The setup for the cluster is the bare minimum needed to replicate the features I used on Heroku's platform, compute and data. It is not production-ready by any means.

[K3s](https://k3s.io/), a lightweight Kubernetes distribution, is installed on the VM. The cluster is comprised of a single node (for now) which is plenty good for hobby projects. It won't be a good idea to host mission-critical workloads on this cluster.

[ExternalDNS](https://github.com/kubernetes-sigs/external-dns) is used to sync DNS records for Services and Ingresses running on the cluster with Cloudflare, the DNS provider for `isupinthe.cloud`.

[PGO by Crunchy Data](https://github.com/CrunchyData/postgres-operator) is the Postgres operator for the cluster. It is used to provision and manage Postgres databases on the cluster.

[Traefik](https://traefik.io/traefik/) is the Ingress Controller for the cluster. It essentially acts as a reverse proxy and load balancer for Services and Ingresses on the cluster. It routes incoming traffic to the appropriate Service/Ingress.

[HashiCorp Terraform](https://www.terraform.io/) is the infrastructure-as-code solution used to provision the cluster. It codifies the configuration for the cluster and its components.

## Observability + Monitoring

[Prometheus](https://prometheus.io/) is used to monitor the cluster. It scrapes metrics from various targets on the cluster and stores them in a time-series database
where they can be queried later. Targets that Prometheus scrapes metrics from include:

- [node_exporter](https://github.com/prometheus/node_exporter) is used to collect metrics about the host system that the cluster is running on. It collects metrics like CPU usage, memory usage, disk I/O, etc.

- [kube-state-metrics (KSM)](https://github.com/kubernetes/kube-state-metrics) is used to collect metrics about the state of Kubernetes objects in the cluster. By listening to the Kubernetes API server, it generates metrics about the state of the cluster's objects like Pods, Deployments, Nodes, etc. These metrics can be used to monitor the health of the Kubernetes objects in the cluster.

- [Traefik's built in observability system](https://doc.traefik.io/traefik/observability/metrics/overview/) collects metrics about the performance and usage of the Traefik Ingress Controller. It collects metrics like the number of requests received, the requests duration, the number of errors, etc.

[Grafana](https://grafana.com/) is used to query and visualize the metrics collected by Prometheus. It is used to create dashboards that display the health and performance of the cluster.

[Alertmanager](https://prometheus.io/docs/alerting/alertmanager/) is used to send alerts based on the metrics collected by Prometheus. If anything goes wrong with the cluster, Alertmanager will page me.
