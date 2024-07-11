FROM alpine:latest
LABEL maintainer="kev <noreply@olenahal>"

RUN apk update && apk upgrade && apk add --no-cache openssl=3.3.1-r3

# Install pptpclient from the edge/testing repository
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ pptpclient

# Create the necessary directories and files for pptpclient
RUN mkdir -p /etc/ppp/peers/
COPY debug /etc/ppp/peers/

# Copy the entry point script into the container
COPY docker-entrypoint.sh /entrypoint.sh

# Ensure the entry point script is executable
RUN chmod +x /entrypoint.sh

# Set the entry point for the container
ENTRYPOINT ["/entrypoint.sh"]
