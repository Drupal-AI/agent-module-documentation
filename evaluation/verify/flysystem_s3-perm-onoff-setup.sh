#!/usr/bin/env bash
# Introspection SETUP: create two roles, fs3_on (granted 'use S3 CORS upload') and fs3_off (not),
# so an agent must inspect live role config to say which can do S3 CORS upload. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create fs3_on >/dev/null 2>&1 || true
drush role:create fs3_off >/dev/null 2>&1 || true
drush role:perm:add fs3_on 'use S3 CORS upload' >/dev/null 2>&1 || true
drush role:perm:remove fs3_off 'use S3 CORS upload' >/dev/null 2>&1 || true
echo "setup: fs3_on has 'use S3 CORS upload', fs3_off does not"
