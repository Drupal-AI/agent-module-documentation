#!/usr/bin/env bash
# Introspection SETUP: create role fs3_uploader granted 'use S3 CORS upload' so an agent can
# inspect roles/permissions and report which role has it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create fs3_uploader >/dev/null 2>&1 || true
drush role:perm:add fs3_uploader 'use S3 CORS upload' >/dev/null 2>&1 || true
echo "setup: role fs3_uploader has 'use S3 CORS upload'"
