#!/usr/bin/env bash
# Introspection CLEANUP: restore jquery_downgrade.settings to shipped default (nothing downgraded).
# The module ships no config/install, so baseline is empty lists / theme downgrade off. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jquery_downgrade.settings")
    ->set("node_ids", [])
    ->set("view_routes", [])
    ->set("enable_theme_downgrade", FALSE)
    ->set("downgrade_themes", [])
    ->save();
' >/dev/null 2>&1
echo "cleanup: jquery_downgrade.settings reset to empty (no downgrade)"
