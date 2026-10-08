#!/usr/bin/env bash
# Execution CLEANUP: restore keep_user to shipped default (50).
set -uo pipefail
cd /var/www/html
drush cset login_history.settings keep_user 50 -y >/dev/null 2>&1
echo "cleanup: login_history.settings keep_user=50"
