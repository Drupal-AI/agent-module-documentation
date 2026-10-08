#!/usr/bin/env bash
# Execution RESET (rest_menu_items): force allowed_menus back to shipped default (empty = all
# menus allowed), so verify FAILS until the agent exposes the footer menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_menu_items.config")->set("allowed_menus", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rest_menu_items.config allowed_menus cleared"
