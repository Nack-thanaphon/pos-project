.DEFAULT_GOAL:=dev

COMPOSE_ALL_FILES :=  -f docker-compose.yaml -f docker-compose.stack.yaml 
COMPOSE_STACK :=  -f  docker-compose.stack.yaml 

include .env
export

# --------------------------
.PHONY: dev watch down build push 


stack:
	docker compose  $(COMPOSE_STACK) up -d --build

up:
	docker compose  $(COMPOSE_ALL_FILES) up -d --build

down:
	docker compose  $(COMPOSE_ALL_FILES) down

