#!/usr/bin/env bash
# Introspection CLEANUP: nothing persistent was written; just clear caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches cleared"
