.DEFAULT_GOAL := dev

COMPOSE_ALL_FILES := -f docker-compose.yaml -f docker-compose.stack.yaml 
COMPOSE_STACK := -f docker-compose.stack.yaml 

-include .env
export

# --------------------------
.PHONY: dev stack up down clean logs

stack:
	docker compose $(COMPOSE_STACK) up -d --build

up:
	docker compose $(COMPOSE_ALL_FILES) up -d --build

down:
	docker compose $(COMPOSE_ALL_FILES) down

clean: down
	docker compose $(COMPOSE_ALL_FILES) down -v --remove-orphans

logs:
	docker compose $(COMPOSE_ALL_FILES) logs -f

dev:
	cd pos-web && npm run dev