.PHONY: setup test dev up down logs ci build push

setup:
	docker-compose run --rm app make setup

test:
	docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci: test

build:
	docker-compose -f docker-compose.yml build app

push:
	docker-compose -f docker-compose.yml push app

dev:
	docker-compose up

up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f
