#!/usr/bin/env bash
# Introspection SETUP: set admin_theme include paths to a known value so the agent can read
# back which paths use the admin theme. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("admin_theme.settings")->set("paths", "/reports\n/reports/*")->save();
' >/dev/null 2>&1
echo "setup: admin_theme.settings paths=/reports (+/reports/*)"
