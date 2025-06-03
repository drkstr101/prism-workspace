##----------------------------------------------------------------------------------------------------------------------
##--------------------------------------------------- Stack Makefile ---------------------------------------------------
##----------------------------------------------------------------------------------------------------------------------
DC=docker compose

.DEFAULT_GOAL := help
.PHONY: help
help : Makefile # Print commands help.
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

export
HOST_UID=$(shell id -u)
HOST_GID=$(shell id -g)
TRAEFIK_NETWORK=prism-next
TRAEFIK_NETWORK_EXISTS=$(shell docker network list | grep ${TRAEFIK_NETWORK} | wc -l)

##
## Docker
##----------------------------------------------------------------------------------------------------------------------
.PHONY: build config down down-v env init logs ps reset restart start stop up

config: ## Display the manifest
	$(DC) config

env: ## Copy default environment variables (if not exists)
	cp --update .env.example .env

build: env ## Build docker images
	$(DC) build

down: ## Remove containers and networks (possible to down specific containers with "make down c1 c2")
	$(DC) down $(filter-out $@,$(MAKECMDGOALS))

down-v: ## Remove containers, networks and volumes (possible to down specific containers with "make down-v c1 c2")
	$(DC) down -v $(filter-out $@,$(MAKECMDGOALS))

init: ## Init docker networks
	@echo "Checking for network"
	docker network create ${TRAEFIK_NETWORK} || true

logs: ## Display container logs (exp: make logs traefik)
	$(DC) logs -f -n 20 $(filter-out $@,$(MAKECMDGOALS))

ps: ## List containers
	$(DC) ps -a

reset: ## Reset the service stack
	$(MAKE) down-v
	$(MAKE) start

restart: ## Restart containers (possible to restart specific containers with "make restart c1 c2")
	$(DC) restart $(filter-out $@,$(MAKECMDGOALS))

start: build ## Build docker images and run containers
	@echo "Starting up service stack: remote-proxy"
	$(MAKE) up

stop: ## Stop containers (possible to stop specific containers with "make stop c1 c2")
	$(DC) stop $(filter-out $@,$(MAKECMDGOALS))

up: init ## Create and start containers
	$(DC) up -d --build --remove-orphans --force-recreate

##
## Shell
##----------------------------------------------------------------------------------------------------------------------
.PHONY: traefik-shell

traefik-shell: ## Connect to traefik container
	$(DC) exec traefik sh
