#!/usr/bin/env bash
# Introspection SETUP: set admin_theme exclude paths to a known value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("admin_theme.settings")->set("exclude_paths", "/admin/content")->save();
' >/dev/null 2>&1
echo "setup: admin_theme.settings exclude_paths=/admin/content"
