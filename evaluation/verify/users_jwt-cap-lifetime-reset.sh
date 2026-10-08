#!/usr/bin/env bash
# Execution RESET: delete users_jwt.config entirely (max_expiration unset), so
# verify FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cdel users_jwt.config >/dev/null 2>&1
echo "reset: users_jwt.config deleted (max_expiration unset)"
