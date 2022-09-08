#!/bin/sh

until [ -f /etc/certs/backend/ca.pem ]; do
  echo "Waiting for backend certificates..."
  sleep 1
done

cat /etc/certs/backend/ca.pem >>/etc/ssl/certs/ca-certificates.crt

cat <<EOF >./traefik.yml
entryPoints:
  http:
    address: ":${EMIGATE_PORT:-12000}"
    forwardedHeaders:
      trustedIPs: "${EMIGATE_TRUSTED_IPS:-127.0.0.1}"
  udp:
    address: ":${EMIGATE_PORT:-12000}/udp"

serversTransport:
  rootCAs:
    - /etc/certs/backend/ca.pem

api:
  dashboard: true

providers:
  file:
    directory: ./conf
EOF

/entrypoint.sh traefik --configFile=./traefik.yml
