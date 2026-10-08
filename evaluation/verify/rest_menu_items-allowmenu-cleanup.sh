#!/usr/bin/env bash
# Execution CLEANUP (rest_menu_items): restore allowed_menus to shipped default (empty = all).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_menu_items.config")->set("allowed_menus", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest_menu_items.config allowed_menus cleared"
