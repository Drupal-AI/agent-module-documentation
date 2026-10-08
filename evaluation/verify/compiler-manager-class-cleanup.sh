#!/usr/bin/env bash
# Introspection CLEANUP: nothing was changed; rebuild caches. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: no changes"
