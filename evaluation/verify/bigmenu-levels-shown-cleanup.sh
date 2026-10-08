#!/usr/bin/env bash
# Introspection CLEANUP for bigmenu: restore max_depth to its install default (1).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bigmenu.settings")->set("max_depth", 1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bigmenu.settings max_depth restored to 1"
