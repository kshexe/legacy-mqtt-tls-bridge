ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache stunnel openssl

COPY rootfs /

RUN chmod +x /etc/cont-init.d/*.sh /etc/services.d/stunnel/run
