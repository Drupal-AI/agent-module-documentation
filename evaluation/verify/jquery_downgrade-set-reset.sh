#!/usr/bin/env bash
# Execution RESET: clear jquery_downgrade.settings so NO page is downgraded (verify FAILS until the
# agent adds the target node). Idempotent. Exit 0.
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
echo "reset: jquery_downgrade.settings cleared"
