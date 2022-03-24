ARG TRAEFIK_IMAGE_TAG=v2.6.1

FROM traefik:$TRAEFIK_IMAGE_TAG

WORKDIR /app

COPY emigate/start.sh ./start.sh
RUN chmod +x ./start.sh

COPY ./emigate/conf/ ./conf/

ENV EMIGATE_PORT=12000 \
    EMIGATE_ADMIN_PORT=12001 \
    EMIGATE_EMISTREAM_ADDRESS=localhost:10000 \
    EMIGATE_EMISTREAM_URL=http://localhost:10000 \
    EMIGATE_EMIPASS_URL=http://localhost:11000 \
    EMIGATE_AUTHO_URL=http://localhost:20000

EXPOSE 12000
EXPOSE 12000/udp
EXPOSE 12001

ENTRYPOINT ["./start.sh"]
CMD []
