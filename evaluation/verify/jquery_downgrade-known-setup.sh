#!/usr/bin/env bash
# Introspection SETUP: configure jquery_downgrade.settings so node 77 uses jQuery 3, so an agent
# can read back which node IDs are downgraded. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jquery_downgrade.settings")
    ->set("node_ids", [77])
    ->set("view_routes", [])
    ->set("enable_theme_downgrade", FALSE)
    ->set("downgrade_themes", [])
    ->save();
' >/dev/null 2>&1
echo "setup: jquery_downgrade.settings node_ids=[77]"
