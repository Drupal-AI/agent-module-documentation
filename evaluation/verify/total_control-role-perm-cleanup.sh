#!/usr/bin/env bash
# Introspection CLEANUP: delete the tc_role role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete tc_role >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: tc_role removed"
