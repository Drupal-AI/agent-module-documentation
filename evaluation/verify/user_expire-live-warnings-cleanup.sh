#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default (send_expiration_warnings=true). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set user_expire.settings send_expiration_warnings 1 -y >/dev/null 2>&1
echo "cleanup: user_expire.settings send_expiration_warnings=true (baseline)"
