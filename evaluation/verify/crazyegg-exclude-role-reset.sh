#!/usr/bin/env bash
# Execution RESET: clear excluded roles so verify FAILS until agent excludes administrator.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("crazyegg.settings")->set("crazyegg_roles_excluded",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: crazyegg.settings crazyegg_roles_excluded=[]"
