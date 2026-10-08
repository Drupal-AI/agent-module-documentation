#!/usr/bin/env bash
# Introspection CLEANUP: delete roles fs3_on and fs3_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete fs3_on >/dev/null 2>&1 || true
drush role:delete fs3_off >/dev/null 2>&1 || true
echo "cleanup: roles fs3_on and fs3_off removed"
