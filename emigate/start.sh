#!/bin/sh

cat <<EOF >./traefik.yml
entryPoints:
  http:
    address: ":${EMIGATE_PORT:-12000}"
    forwardedHeaders:
      trustedIPs: "${EMIGATE_TRUSTED_IPS:-127.0.0.1}"
  udp:
    address: ":${EMIGATE_PORT:-12000}/udp"

api:
  dashboard: true

providers:
  file:
    directory: ./conf
EOF

/entrypoint.sh traefik --configFile=./traefik.yml
