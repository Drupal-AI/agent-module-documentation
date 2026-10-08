#!/usr/bin/env bash
# Introspection CLEANUP: delete users_jwt.config entirely, restoring the
# baseline (unset, since the module ships no config/install). Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush -y cdel users_jwt.config >/dev/null 2>&1
echo "cleanup: users_jwt.config deleted"
