#!/usr/bin/env bash
# Execution CLEANUP: delete users_jwt.config, restoring the unset baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cdel users_jwt.config >/dev/null 2>&1
echo "cleanup: users_jwt.config deleted"
