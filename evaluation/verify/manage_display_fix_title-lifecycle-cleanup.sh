#!/usr/bin/env bash
# Introspection CLEANUP: nothing was written by the matching setup beyond a cache reset, so
# this only refreshes caches to leave the site at baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches refreshed; no configuration was changed by this case"
