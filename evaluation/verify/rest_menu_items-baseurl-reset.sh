#!/usr/bin/env bash
# Execution RESET (rest_menu_items): force base_url back to the shipped default (empty), so
# verify FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_menu_items.config")->set("base_url", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest_menu_items.config base_url cleared"
