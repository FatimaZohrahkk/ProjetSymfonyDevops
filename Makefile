up:
	docker-compose up -d --build

down:
	docker-compose down -v --remove-orphans

bash:
	docker exec -it symfony-app bash

nginx-logs:
	docker logs -f symfony-nginx

phpmyadmin:
	open http://localhost:8081

app:
	open http://localhost:8080

