#!/usr/bin/env bash
# Introspection CLEANUP (shared): nothing was planted; just rebuild caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (no baseline change)"
