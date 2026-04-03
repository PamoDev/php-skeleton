#!/bin/sh
set -e

echo "Building Prod Image..."
docker build --target prod -t pamodev/php-fpm-alpine:latest -t pamodev/php-fpm-alpine:8.4 -f etc/PhpAlpineDockerfile .

echo "Building Dev Image..."
docker build --target dev -t pamodev/php-fpm-alpine:dev -f etc/PhpAlpineDockerfile .

echo "All builds finished"
