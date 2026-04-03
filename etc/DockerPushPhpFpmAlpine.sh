#!/bin/sh
set -e

echo "Pushing Prod Images..."
docker push pamodev/php-fpm-alpine:latest
docker push pamodev/php-fpm-alpine:8.4

echo "Pushing Dev Image..."
docker push pamodev/php-fpm-alpine:dev

echo "All images pushed successfully"
