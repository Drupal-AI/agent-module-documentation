#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default (no excluded roles). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("crazyegg.settings")->set("crazyegg_roles_excluded",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: crazyegg.settings crazyegg_roles_excluded=[]"
