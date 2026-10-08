#!/usr/bin/env bash
# Execution RESET: force keep_user back to the shipped default (50) so a "set it to 10"
# task genuinely fails until performed. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset login_history.settings keep_user 50 -y >/dev/null 2>&1
echo "reset: login_history.settings keep_user=50"
