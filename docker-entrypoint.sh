#!/bin/sh
set -eu

if [ -d /opt/custom-certificates ]; then
  echo "Trusting custom certificates from /opt/custom-certificates."
  export NODE_OPTIONS="--use-openssl-ca ${NODE_OPTIONS:-}"
  export SSL_CERT_DIR=/opt/custom-certificates
  if command -v c_rehash >/dev/null 2>&1; then
    c_rehash /opt/custom-certificates || true
  fi
fi

if [ "$#" -gt 0 ]; then
  exec n8n "$@"
else
  exec n8n
fi
