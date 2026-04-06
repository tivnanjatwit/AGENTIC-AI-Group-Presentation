# syntax=docker/dockerfile:1.7

ARG NODE_VERSION=24.13.1
ARG N8N_VERSION=latest

# Dev container target: includes package manager and common tooling so
# VS Code Dev Containers setup succeeds.
FROM node:${NODE_VERSION}-alpine AS dev

RUN apk add --no-cache \
    bash \
    sudo \
    shadow \
    git \
    openssh \
    tini \
    tzdata \
    ca-certificates \
    libc6-compat \
    curl

# Ensure a predictable non-root user for VS Code.
RUN addgroup -S node || true \
    && adduser -S -G node -h /home/node node || true \
    && mkdir -p /home/node /workspace \
    && chown -R node:node /home/node /workspace \
    && echo "node ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/node \
    && chmod 0440 /etc/sudoers.d/node

# Install n8n in dev too so local validation/run commands work.
RUN npm install --global n8n@${N8N_VERSION} \
    && npm cache clean --force

WORKDIR /workspace
USER node

EXPOSE 5678
CMD ["sh", "-lc", "sleep infinity"]


# Runtime target: official n8n-style image with tini entrypoint.
FROM node:${NODE_VERSION}-alpine AS runtime

ARG N8N_VERSION

RUN apk add --no-cache \
    tini \
    tzdata \
    ca-certificates \
    openssl \
    libc6-compat

RUN addgroup -S node || true \
    && adduser -S -G node -h /home/node node || true \
    && mkdir -p /home/node/.n8n \
    && chown -R node:node /home/node

RUN npm install --global n8n@${N8N_VERSION} \
    && npm cache clean --force

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /home/node
USER node

EXPOSE 5678
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD []
