#!/usr/bin/env bash
# Introspection SETUP: enable ape_test so its test routes/endpoints are live and inspectable.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en ape_test -y >/dev/null 2>&1 || true
echo "setup: ape_test enabled"
