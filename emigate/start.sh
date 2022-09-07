#!/bin/sh

cat <<EOF >./traefik.yml
entryPoints:
  http:
    address: ":${EMIGATE_PORT:-12000}"
  udp:
    address: ":${EMIGATE_PORT:-12000}/udp"

api:
  dashboard: true

providers:
  file:
    directory: ./conf
EOF

/entrypoint.sh traefik --configFile=./traefik.yml
