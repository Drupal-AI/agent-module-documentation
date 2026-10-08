#!/usr/bin/env bash
# Execution CLEANUP: restore onlyone_new_menu_entry to shipped default (false) and rebuild
# routes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("onlyone.settings")->set("onlyone_new_menu_entry", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: onlyone_new_menu_entry restored to false"
