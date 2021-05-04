# Project variables
PROJECT_NAME ?= todobackend
ORG_NAME ?= pklata
REPO_NAME ?= todobackend

# Filenames
DEV_COMPOSE_FILE := docker/dev/docker-compose.yml
REL_COMPOSE_FILE := docker/release/docker-compose.yml

# Docker Compose Project Names
REL_PROJECT := $(PROJECT_NAME)$(BUILD_ID)
DEV_PROJECT := $(PROJECT_NAME)dev

.PHONY: test build release clean

test:
	${INFO} "Building images..."
	@docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) build
	${INFO} "Ensuring database is ready..."
	@docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up agent
	${INFO} "Running tests..."
	@docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up test
	${INFO} "Testing complete"

build:
	${INFO} "Building application artifacts..."
	@docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up builder
	${INFO} "Build complete"

release:
	${INFO} "Building images..."
	@docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) build
	${INFO} "Ensuring database is ready..."
	@docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up agent
	${INFO} "Collecting static files..."
	@docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) run --rm app manage.py collectstatic --noinput
	${INFO} "Running database migrations..."
	@docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) run --rm app manage.py migrate --noinput
	@docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up test
	${INFO} "Acceptance testing complete"

clean:
	${INFO} "Destroying development environment..."
	@docker-compose -f $(DEV_COMPOSE_FILE) kill
	@docker-compose -f $(DEV_COMPOSE_FILE) rm -f -v
	@docker-compose -f $(REL_COMPOSE_FILE) kill
	@docker-compose -f $(REL_COMPOSE_FILE) rm -f -v
	@docker images -q -f dangling=true -f label=application=$(REPO_NAME) | xargs -I ARGS docker rmi -f ARGS
	${INFO} "Clean complete"


# Cosmetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

#Shell Functions
INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE