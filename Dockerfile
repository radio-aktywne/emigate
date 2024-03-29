ARG TRAEFIK_IMAGE_TAG=v2.8.4

FROM traefik:$TRAEFIK_IMAGE_TAG

WORKDIR /app

COPY emigate/start.sh ./start.sh
RUN chmod +x ./start.sh

COPY ./emigate/conf/ ./conf/

ENV EMIGATE_PORT=12000 \
    EMIGATE_EMISTREAM_ADDRESS=localhost:10000 \
    EMIGATE_EMISTREAM_URL=http://localhost:10000 \
    EMIGATE_EMIPASS_URL=http://localhost:11000 \
    EMIGATE_AUTHGATE_URL=https://localhost:20000 \
    EMIGATE_TRUSTED_IPS=127.0.0.1

EXPOSE 12000
EXPOSE 12000/udp

ENTRYPOINT ["./start.sh"]
CMD []
