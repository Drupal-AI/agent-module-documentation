#!/usr/bin/env bash
# Introspection CLEANUP: restore login_history keep_user to its shipped default (50).
set -uo pipefail
cd /var/www/html
drush cset login_history.settings keep_user 50 -y >/dev/null 2>&1
echo "cleanup: login_history.settings keep_user=50"
