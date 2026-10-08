#!/usr/bin/env bash
# Execution CLEANUP: ensure jwt_auth_consumer is left ENABLED (shipped/expected state for this
# site). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y en jwt_auth_consumer >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jwt_auth_consumer enabled"
