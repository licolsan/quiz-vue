DC-dev  = docker-compose -f docker-compose.dev.yml
DC-prod = docker-compose -f docker-compose.prod.yml
DC-network = docker network

# Setup network, build & pull images
setup:
	${DC-network} ls | grep vue-learning-network > /dev/null || ${DC-network} create vue-learning-network
	${DC-dev} build
	${DC-prod} build

# For development environment
start-dev:
	${DC-dev} start

stop-dev:
	${DC-dev} stop

up-dev:
	${DC-dev} up -d

clean-dev:
	${DC-dev} down -v

# For production environment
start-prod:
	${DC-prod} start

stop-prod:
	${DC-prod} stop

up-prod:
	${DC-prod} up -d

clean-prod:
	${DC-prod} down -v
