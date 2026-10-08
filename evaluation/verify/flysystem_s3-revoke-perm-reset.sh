#!/usr/bin/env bash
# Execution RESET: (re)create role fs3_revoke WITH the 'use S3 CORS upload' permission so verify
# FAILS (perm still present) until the agent revokes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create fs3_revoke >/dev/null 2>&1 || true
drush role:perm:add fs3_revoke 'use S3 CORS upload' >/dev/null 2>&1 || true
echo "reset: role fs3_revoke exists WITH 'use S3 CORS upload'"
