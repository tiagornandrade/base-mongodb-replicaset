COMPOSE_FILE := docker-compose.yml
MONGO_INIT_SCRIPT := ./scripts/mongo_init.js

up:
	docker-compose -f $(COMPOSE_FILE) up -d

init-mongo:
	# Espera os containers MongoDB estarem prontos
	@echo "Esperando MongoDB iniciar..."
	@sleep 5
	# Executa o script de inicialização do MongoDB
	docker exec -i mongo-primary mongosh /docker-entrypoint-initdb.d/init_replica.js

down:
	docker-compose -f $(COMPOSE_FILE) down

clean:
	docker-compose -f $(COMPOSE_FILE) down -v

verify:
	docker exec -it mongo-primary mongosh --eval "rs.status()"

mongosh-primary:
	docker exec -it mongo-primary mongosh

mongosh-secondary-1:
	docker exec -it mongo-secondary-1 mongosh

mongosh-secondary-2:
	docker exec -it mongo-secondary-2 mongosh

