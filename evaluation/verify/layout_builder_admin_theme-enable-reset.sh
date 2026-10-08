#!/usr/bin/env bash
# Execution RESET: force lbat_enable_admin_theme OFF so verify FAILS until the agent turns the
# admin-theme override ON. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_admin_theme.config")
    ->set("lbat_enable_admin_theme", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lbat_enable_admin_theme=false"
