#!/usr/bin/env bash

set -e

docker-compose -f docker-compose.yaml -f docker-compose.security.yaml down