#!/usr/bin/env bash
# Execution CLEANUP: delete role fs3_revoke. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete fs3_revoke >/dev/null 2>&1 || true
echo "cleanup: role fs3_revoke removed"
