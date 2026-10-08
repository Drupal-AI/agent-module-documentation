#!/usr/bin/env bash
# Execution RESET: force lbat_enable_admin_theme ON (default) so verify FAILS until the agent
# turns the admin-theme override OFF. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_admin_theme.config")
    ->set("lbat_enable_admin_theme", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lbat_enable_admin_theme=true"
