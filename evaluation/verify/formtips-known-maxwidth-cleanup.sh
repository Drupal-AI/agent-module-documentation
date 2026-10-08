#!/usr/bin/env bash
# Introspection CLEANUP: restore formtips.settings:formtips_max_width to the shipped default.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_max_width '500px' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: formtips.settings formtips_max_width restored to 500px"
