setup:
	docker compose build
start:
	docker compose up -d  
run-web:
	docker exec -it rails rails s -b 0.0.0.0
run-postgres:
	docker exec -it postgres bash
logs:
	docker compose logs