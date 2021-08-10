FROM alpine:edge
MAINTAINER kev <noreply@olenahal>

RUN apk add --no-cache \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            pptpclient

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
#RUN ["mknod","/dev/ppp", "c", "108", "0"]
ENTRYPOINT ["entrypoint.sh"]
