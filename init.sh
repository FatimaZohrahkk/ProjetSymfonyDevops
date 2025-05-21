#!/bin/bash
docker-compose up -d
docker-compose exec php composer install
docker-compose exec php bin/console doctrine:database:create --if-not-exists
docker-compose exec php bin/console doctrine:migrations:migrate -n