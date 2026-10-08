#!/usr/bin/env bash
# Introspection SETUP: set force_password_change settings to a known state so an inspecting
# agent can read them back: first-time-login forcing ON and check-on-login-only ON.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset force_password_change.settings first_time_login_password_change 1 -y >/dev/null 2>&1
drush cset force_password_change.settings check_login_only 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: force_password_change.settings first_time_login_password_change=1 check_login_only=1"
