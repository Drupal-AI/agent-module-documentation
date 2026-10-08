#!/usr/bin/env bash
# Introspection SETUP: cl_editorial ships a demo SDC component; ensure the plugin registry is
# built so it is discoverable on the running site. No config to create. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: SDC registry rebuilt; cl_editorial:component-card is discoverable"
