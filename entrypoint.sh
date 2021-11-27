#!/bin/sh
echo "Starting Cloudflared tunnel..."
exec /usr/local/bin/cloudflared tunnel --no-autoupdate --no-tls-verify "$@"
