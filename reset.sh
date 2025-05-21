#!/bin/bash
docker-compose down -v
docker-compose up -d --build

# Attendre MySQL
while ! docker-compose exec db mysqladmin ping -uroot -proot --silent; do
    sleep 2
done

# Installer dépendances et migrations
docker-compose exec php composer install
docker-compose exec php bin/console doctrine:database:create --if-not-exists
docker-compose exec php bin/console doctrine:migrations:migrate -n

echo "✅ Prêt ! http://localhost:8080"