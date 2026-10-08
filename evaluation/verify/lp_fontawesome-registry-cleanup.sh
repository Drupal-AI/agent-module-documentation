#!/usr/bin/env bash
# Introspection CLEANUP: nothing to restore (no state changed); rebuild caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: no state changed"
