##----------------------------------------------------------------------------------------------------------------------
##------------------------------------------------ Tools Stack Makefile ------------------------------------------------
##----------------------------------------------------------------------------------------------------------------------
SHELL=bash

DC ?= docker compose

.DEFAULT_GOAL := help
.PHONY: help

help: Makefile # Print commands help
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Docker
##----------------------------------------------------------------------------------------------------------------------
.PHONY: build config down down-v logs ps reset restart run start stop up

config: ## Display the manifest
	$(DC) config

build: ## Build docker images
	$(DC) build

down: ## Remove containers and networks
	$(DC) down $(filter-out $@,$(MAKECMDGOALS))

down-v: ## Remove containers, networks and volumes
	$(DC) down -v $(filter-out $@,$(MAKECMDGOALS))

logs: ## Display container logs (exp: make logs master)
	$(DC) logs -f -n 50 $(filter-out $@,$(MAKECMDGOALS))

ps: ## List containers
	$(DC) ps -a

reset: ## Reset the service stack
	bash reset.sh

restart: ## Restart containers (possible to restart specific containers with "make restart c1 c2")
	$(DC) restart $(filter-out $@,$(MAKECMDGOALS))

start: build ## Build docker images and run containers
	$(MAKE) up

stop: ## Stop containers (possible to stop specific containers with "make stop c1 c2")
	$(DC) stop $(filter-out $@,$(MAKECMDGOALS))

up: ## Create and start containers
	$(DC) up -d --remove-orphans --force-recreate $(filter-out $@,$(MAKECMDGOALS))

