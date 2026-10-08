#!/usr/bin/env bash
# Introspection SETUP: seed two known themes into admin_theme_favicon_themes. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("emulsify_tools.settings")
    ->set("admin_theme_favicon_themes", ["olivero", "claro_child_known"])->save();
' >/dev/null 2>&1
echo "setup: admin_theme_favicon_themes = [olivero, claro_child_known]"
