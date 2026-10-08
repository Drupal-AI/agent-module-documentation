#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default weight (6) for the Authoring information tab.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset vertical_tabs_config.order vertical_tabs_config_author 6 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vertical_tabs_config_author restored to 6"
