#!/usr/bin/env bash
# Introspection CLEANUP: delete the migsui_operator role (restores baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete migsui_operator >/dev/null 2>&1 || true
echo "cleanup: role migsui_operator deleted"
