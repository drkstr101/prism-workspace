# Prism Cloud

Cloud-native event-driven services with [K3S](https://docs.k3s.io/)
and [Knative](https://knative.dev/docs/concepts/).

## Getting Started

### Start Reverse Proxy

This service depends on [reverse-proxy](../reverse-proxy/README.md).

### Start the service

```shell
make start
```

Enjoy ! 🥳

### Traefik dashboard

> <https://traefik.k3s.localhost/>

Below is an example to install nginx. You should run it inside the k8s container.

```shell
kubectl apply -f 00-nginx.yaml
```

Visit <http://nginx.k3s.localhost>

## Ingress nginx controller

By default, traefik is installed as an ingress reverse proxy, if you want to allow ingress nginx follow the following instructions

### Connect to k8s container

```shell
make shell
```

### Create namespace

```shell
kubectl create ns ingress-nginx
```

### Add the helm ingress repository

```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

### Install nginx ingress controller

```shell
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx
```

## Routing

Router >> \*.k3s.localhost >> Docker Traefik >> K3S container >> Ingress (traefik OR nginx) >> Service

## K3S config directories

| Node   | Directory                             | Description                                                                                                                                                    |
| ------ | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Server | /output                               | k3s will generate a kubeconfig.yaml in this directory.                                                                                                         |
| Server | /var/lib/rancher/k3s/server/manifests | This directory is where you put all the (yaml) configuration files of the Kubernetes resources.                                                                |
| Agent  | /var/lib/rancher/k3s/agent/images     | this is where you would place an alternative traefik image (saved as a .tar file with'docker save'), if you want to use it, instead of the traefik:v3.1 image. |

## Available apps

- [Install Portainer](.manifests/tools/helm/portainer/README.md)
- [Install Vault](.manifests/tools/helm/vault/README.md)

## References

- <https://github.com/its-knowledge-sharing/K3S-Demo/blob/production/docker-compose.yaml>
- <https://docs.k3s.io/cli/server>
- <https://thenets.org/how-to-create-a-k3s-cluster-with-nginx-ingress-controller/>
- <https://blog.stephane-robert.info/post/homelab-ingress-k3s-certificats-self-signed/>

### Addons

- <https://github.com/its-knowledge-sharing/K3S-Demo-Addons>

### Custom coredns

- <https://github.com/owncloud/docs-ocis/issues/716>
- <https://learn.microsoft.com/en-us/azure/aks/coredns-custom#hosts-plugin>
