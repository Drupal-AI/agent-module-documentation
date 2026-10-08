#!/usr/bin/env bash
# Introspection CLEANUP: restore formtips.settings:formtips_selectors to shipped default ''.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_selectors '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: formtips.settings formtips_selectors restored to ''"
