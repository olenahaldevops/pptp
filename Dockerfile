FROM alpine:edge
MAINTAINER kev <noreply@olenahal>

RUN apk add --no-cache \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            pptpclient
RUN mknod /dev/ppp c 108 0
RUN chmod 600 /dev/ppp

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
