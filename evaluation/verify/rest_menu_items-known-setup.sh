#!/usr/bin/env bash
# Introspection SETUP (rest_menu_items): write known values to rest_menu_items.config so an
# inspecting agent can read back the decoupled base_url and which menu is exposed. Only touches
# base_url and allowed_menus. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rest_menu_items.config")
    ->set("base_url", "https://api.known.test")
    ->set("allowed_menus", ["main" => "main"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest_menu_items.config base_url=https://api.known.test allowed_menus={main}"
