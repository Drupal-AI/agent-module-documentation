#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (-1 / false).
set -uo pipefail
cd /var/www/html
drush cset admin_user_language.settings default_language_to_assign '-1' -y >/dev/null 2>&1
drush cset admin_user_language.settings prevent_user_override false -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: admin_user_language.settings restored to defaults (-1 / false)"
