#!/usr/bin/env bash
# Execution CLEANUP: reset jquery_downgrade.settings to empty. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jquery_downgrade.settings")
    ->set("node_ids", [])->set("view_routes", [])->set("enable_theme_downgrade", FALSE)->set("downgrade_themes", [])->save();
' >/dev/null 2>&1
echo "cleanup: jquery_downgrade.settings cleared"
