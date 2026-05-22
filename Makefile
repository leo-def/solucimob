# Variables
DOCKER_COMPOSE = docker-compose

.PHONY: all
all: build

# Install (Verify submodules)
.PHONY: install
install:
	@echo "Checking submodules setup..."
	git submodule update --init --recursive

# Build services
.PHONY: build
build:
	$(DOCKER_COMPOSE) build

# Run local development cluster
.PHONY: dev
dev:
	$(DOCKER_COMPOSE) up

# Shutdown cluster
.PHONY: down
down:
	$(DOCKER_COMPOSE) down

# Clean docker containers, volumes, and networks
.PHONY: clean
clean:
	$(DOCKER_COMPOSE) down -v --rmi local
