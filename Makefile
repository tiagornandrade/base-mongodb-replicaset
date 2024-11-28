.PHONY: up init_replica down verify

up:
	docker-compose up -d

init_replica:
	@echo "Aguardando MongoDB iniciar..."
	@sleep 10
	@echo "Inicializando o Replica Set..."
	docker exec -it base-mongodb-replicaset-mongo1-1 mongosh --eval "rs.initiate({_id: 'rs0', members: [{_id: 0, host: 'base-mongodb-replicaset-mongo1-1:27017'}, {_id: 1, host: 'base-mongodb-replicaset-mongo2-1:27018'}, {_id: 2, host: 'base-mongodb-replicaset-mongo3-1:27019'}]})"
	docker exec -it base-mongodb-replicaset-mongo1-1 mongosh --eval "rs.isMaster()"

init: up init_replica

down:
	docker-compose down

verify:
	docker exec -it base-mongodb-replicaset-mongo1-1 mongosh --eval "rs.status()"
