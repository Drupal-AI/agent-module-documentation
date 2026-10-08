#!/usr/bin/env bash
# Introspection SETUP: ensure the restriction is ON (disabled=0 => user 1 locked) so an agent can
# determine the current protection state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset disable_user_1_edit.settings disabled 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: disable_user_1_edit.settings disabled=0 (restriction ON, user 1 locked)"
