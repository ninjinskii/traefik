#!/bin/sh

sudo apt install libnss3-tools
./mkcert -install
mkdir -p certs/
./mkcert -cert-file certs/mkcert.pem -key-file certs/mkcert-key.pem \
  "njk.localhost" "$(hostname -f).localhost" "*.njk.localhost" "*.$(hostname -f).localhost"
docker-compose up -d
