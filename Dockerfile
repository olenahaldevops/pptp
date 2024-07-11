FROM alpine:latest
LABEL maintainer="kev <noreply@olenahal>"

# Install pptpclient from the edge/testing repository
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ pptpclient

# Copy the entry point script into the container
COPY docker-entrypoint.sh /entrypoint.sh

# Ensure the entry point script is executable
RUN chmod +x /entrypoint.sh

# Set the entry point for the container
ENTRYPOINT ["/entrypoint.sh"]
