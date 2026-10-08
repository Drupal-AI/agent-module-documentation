#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (length 8, strength 3, auto_generate 1).
set -uo pipefail
cd /var/www/html
drush -y cset better_passwords.settings length 8 >/dev/null 2>&1
drush -y cset better_passwords.settings strength 3 >/dev/null 2>&1
drush -y cset better_passwords.settings auto_generate 1 >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: better_passwords.settings restored to defaults (length 8, strength 3, auto_generate 1)"
