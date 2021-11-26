#!/bin/sh
echo "Starting Cloudflared tunnel..."
SSL_CERT_FILE=/etc/cloudflared/le-chain.pem exec /usr/local/bin/cloudflared tunnel --no-autoupdate --no-tls-verify "$@"
