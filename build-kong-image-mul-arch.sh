#!/usr/bin/env bash
docker buildx build --builder multiarch \
   --platform linux/amd64 \
   -f Dockerfile \
   -t suriyaruk/kong-build-from-source:3.9.1-1.29.2.3 \
   --push \
.
