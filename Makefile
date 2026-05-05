.PHONY: cert up down restart

DOCKER ?= docker
COMPOSE ?= docker compose
PROJECT_DIR := $(CURDIR)

cert:
	$(DOCKER) run --rm -v $(PROJECT_DIR):/work -w /work alpine:3.20 sh -lc 'apk add --no-cache openssl >/dev/null && mkdir -p certs && openssl req -x509 -newkey rsa:4096 -nodes -out certs/localhost.crt -keyout certs/localhost.key -days 36500 -subj "/CN=*.localhost" -addext "subjectAltName=DNS:*.localhost,DNS:localhost"'

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) down && $(COMPOSE) up -d