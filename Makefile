.PHONY: setup test dev up down logs ci build push

DOCKER_COMPOSE := docker compose

setup:
	$(DOCKER_COMPOSE) run --rm app make setup

test:
	$(DOCKER_COMPOSE) -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci: test

build:
	$(DOCKER_COMPOSE) -f docker-compose.yml build app

push:
	$(DOCKER_COMPOSE) -f docker-compose.yml push app

dev:
	$(DOCKER_COMPOSE) up

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs -f
