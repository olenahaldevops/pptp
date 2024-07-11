FROM alpine:latest
LABEL maintainer="kev <noreply@olenahal>"

# Update the package list and upgrade OpenSSL to the fixed version
RUN apk update && apk upgrade && apk add --no-cache openssl=3.1.6-r0

# Install pptpclient from the edge/testing repository
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ pptpclient

# Copy the entry point script into the container
COPY docker-entrypoint.sh /entrypoint.sh

# Ensure the entry point script is executable
RUN chmod +x /entrypoint.sh

# Set the entry point for the container
ENTRYPOINT ["/entrypoint.sh"]
