setup:
	docker compose build
up:
	docker compose up -d
stop:
	docker compose down
start:
	docker exec -it rails rails s -b 0.0.0.0
run-postgres:
	docker exec -it postgres bash
logs:
	docker compose logs