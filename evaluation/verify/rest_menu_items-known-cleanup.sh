#!/usr/bin/env bash
# Introspection CLEANUP (rest_menu_items): restore shipped defaults for the two keys touched by
# setup (base_url empty, allowed_menus empty = all menus). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_menu_items.config")
    ->set("base_url", "")
    ->set("allowed_menus", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest_menu_items.config base_url and allowed_menus restored to defaults"
