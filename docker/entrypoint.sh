#!/bin/sh
set -e

echo "→ Installation des dépendances Composer"
composer install --optimize-autoloader --no-interaction

echo "→ Création de la BDD si nécessaire"
php bin/console doctrine:database:create --if-not-exists --no-interaction

echo "→ Exécution des migrations"
php bin/console doctrine:migrations:migrate --no-interaction

echo "→ Nettoyage du cache"
php bin/console cache:clear

exec php-fpm