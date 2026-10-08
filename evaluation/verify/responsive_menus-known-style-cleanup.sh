#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset responsive_menus.configuration style responsive_menus_simple -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: responsive_menus.configuration style reset to responsive_menus_simple"
