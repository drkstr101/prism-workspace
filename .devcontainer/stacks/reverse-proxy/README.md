# Stack

## About

This repository contains a traefik reverse proxy and a docker image to generate self-signed certificate for development projects.

## Requirements

* git
* docker
* docker compose
* Taskfile (<https://taskfile.dev/>) OR Makefile

## How to ?

### Clone the project

```shell
git clone git@github.com:devgine/stack.git
```

## Setup

```shell
make up
```

Visit traefik dashboard to make sure the installation is successfully done <https://dashboard.prism.localhost>, or by visiting the api <https://dashboard.prism.localhost/api/rawdata>.

> **Important**
> To use the traefik certificate your local domain must be a subdomain of _prism.localhost_
> For example : _my_project.prism.localhost_

## How to use services with traefik

Below is an example of using the nginx service with traefik

After running the nginx container, the service should be accessible by visiting <https://nginx.prism.localhost>

```yaml
services:
  nginx:
    container_name: nginx
    image: nginx:latest
    labels:
      - traefik.enable=true
      - traefik.docker.network=prism-next
      - traefik.http.routers.nginx-https.rule=Host(`nginx.prism.localhost`)
      - traefik.http.routers.nginx-https.entrypoints=websecure
      - traefik.http.routers.nginx-https.tls=true
      - traefik.http.services.nginx-loadbalancer.loadbalancer.server.port=80
    networks:
      - prism-next

networks:
  prism-next:
    external: true
```

## Chrome trust insecure localhost

Open Chrome browser and visit the below URL then allow invalid certificates for resources loaded from localhost.

```text
chrome://flags/#allow-insecure-localhost
```
