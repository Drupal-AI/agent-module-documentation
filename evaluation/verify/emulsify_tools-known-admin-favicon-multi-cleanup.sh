#!/usr/bin/env bash
# Introspection CLEANUP: restore empty list (default). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("emulsify_tools.settings")
    ->set("admin_theme_favicon_themes", [])->save();
' >/dev/null 2>&1
echo "cleanup: admin_theme_favicon_themes restored to [] (default)"
