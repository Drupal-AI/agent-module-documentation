#!/usr/bin/env bash
# Execution RESET: clear admin_theme_favicon_themes so verify FAILS until the agent adds olivero.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("emulsify_tools.settings")
    ->set("admin_theme_favicon_themes", [])->save();
' >/dev/null 2>&1
echo "reset: admin_theme_favicon_themes = []"
