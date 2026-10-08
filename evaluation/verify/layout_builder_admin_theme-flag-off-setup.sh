#!/usr/bin/env bash
# Introspection SETUP: set the module's toggle lbat_enable_admin_theme to FALSE so an
# inspecting agent can read that Layout Builder is currently NOT forced to the admin theme.
# The value lives in the module's own config object. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_admin_theme.config")
    ->set("lbat_enable_admin_theme", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_builder_admin_theme.config lbat_enable_admin_theme=false"
