#!/usr/bin/env bash
# Execution RESET: set onlyone.settings onlyone_new_menu_entry=false so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("onlyone.settings")->set("onlyone_new_menu_entry", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: onlyone.settings onlyone_new_menu_entry=false"
