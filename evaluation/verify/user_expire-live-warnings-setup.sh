#!/usr/bin/env bash
# Introspection SETUP: disable expiration-warning emails so an inspecting agent can read the
# flag. Baseline default is true. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set user_expire.settings send_expiration_warnings 0 -y >/dev/null 2>&1
echo "setup: user_expire.settings send_expiration_warnings=false"
