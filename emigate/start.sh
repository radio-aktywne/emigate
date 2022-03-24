#!/bin/sh

cat <<EOF >./traefik.yml
entryPoints:
  http:
    address: ":${EMIGATE_PORT:-12000}"
  udp:
    address: ":${EMIGATE_PORT:-12000}/udp"
  admin:
    address: ":${EMIGATE_ADMIN_PORT:-12001}"

api:
  dashboard: true

providers:
  file:
    directory: ./conf
EOF

/entrypoint.sh traefik --configFile=./traefik.yml
