#!/usr/bin/env bash
# Execution RESET: restore shipped defaults so length is 8 (verify FAILS until agent sets 12).
set -uo pipefail
cd /var/www/html
drush -y cset better_passwords.settings length 8 >/dev/null 2>&1
drush -y cset better_passwords.settings strength 3 >/dev/null 2>&1
drush -y cset better_passwords.settings auto_generate 1 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: better_passwords.settings length=8 (defaults)"
