#!/usr/bin/env bash
# Execution RESET: seed a placeholder theme so verify FAILS until the agent replaces it with canvas_stark.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("emulsify_tools.settings")
    ->set("admin_theme_favicon_themes", ["placeholder_reset_theme"])->save();
' >/dev/null 2>&1
echo "reset: admin_theme_favicon_themes = [placeholder_reset_theme]"
