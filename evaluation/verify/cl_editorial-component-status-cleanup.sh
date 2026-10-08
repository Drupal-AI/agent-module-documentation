#!/usr/bin/env bash
# Introspection CLEANUP: nothing was created; just rebuild caches. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (no state was created)"
