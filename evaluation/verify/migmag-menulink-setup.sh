#!/usr/bin/env bash
# Introspection SETUP: enable migmag_menu_link_migrate (pulls in migmag/migmag_process). Idempotent.
set -uo pipefail
cd /var/www/html
drush en migmag_menu_link_migrate -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migmag_menu_link_migrate enabled"
