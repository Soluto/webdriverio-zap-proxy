#!/usr/bin/env bash

set -e

docker-compose -f docker-compose.yaml -f docker-compose.security.yaml pull --parallel
docker-compose -f docker-compose.yaml -f docker-compose.security.yaml up --build --exit-code-from black-box