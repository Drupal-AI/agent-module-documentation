#!/usr/bin/env bash
# Introspection CLEANUP (error_page M2): nothing mutated; rebuild caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: no changes to revert"
