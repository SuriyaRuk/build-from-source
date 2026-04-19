#!/bin/sh
set -e

export KONG_NGINX_DAEMON=${KONG_NGINX_DAEMON:-off}

# Handle kong migrations and start commands
if [ "$1" = "kong" ]; then
    # Ensure /usr/local/kong is writable
    PREFIX=${KONG_PREFIX:-/usr/local/kong}
    mkdir -p "$PREFIX"

    if [ "$2" = "docker-start" ]; then
        # Run migrations if KONG_DATABASE is not off
        if [ "${KONG_DATABASE}" != "off" ] && [ -n "${KONG_DATABASE}" ]; then
            kong migrations bootstrap --v 2>/dev/null || \
            kong migrations up --v 2>/dev/null || true
        fi

        shift 2
        exec /usr/local/bin/kong start --v "$@"
    fi
fi

exec "$@"
