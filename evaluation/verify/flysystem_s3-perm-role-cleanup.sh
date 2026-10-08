#!/usr/bin/env bash
# Introspection CLEANUP: delete role fs3_uploader. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete fs3_uploader >/dev/null 2>&1 || true
echo "cleanup: role fs3_uploader removed"
