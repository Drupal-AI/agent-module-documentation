#!/usr/bin/env bash
# Introspection SETUP: turn the restriction OFF (disabled=1 => user 1 editable again) so an agent can
# determine the current protection state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset disable_user_1_edit.settings disabled 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: disable_user_1_edit.settings disabled=1 (restriction OFF, user 1 editable)"
