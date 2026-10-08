#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (lbat_enable_admin_theme=TRUE).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_admin_theme.config")
    ->set("lbat_enable_admin_theme", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: layout_builder_admin_theme.config lbat_enable_admin_theme=true (default)"
