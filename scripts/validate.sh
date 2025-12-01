#!/bin/bash
set -e
# simple healthcheck: expect 200 on root
HOST=localhost
PORT=4000
curl -f http://$HOST:$PORT/ || { echo "Healthcheck failed"; exit 1; }
echo "App healthy"
