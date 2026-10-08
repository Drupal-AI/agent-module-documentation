#!/usr/bin/env bash
# Execution CLEANUP (rest_menu_items): restore base_url to the shipped default (empty).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_menu_items.config")->set("base_url", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest_menu_items.config base_url cleared"
