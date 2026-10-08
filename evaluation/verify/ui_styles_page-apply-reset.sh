#!/usr/bin/env bash
# Execution RESET (ui_styles_page): clear ALL ui_styles_page region styles on the default
# theme so verify FAILS until the agent applies one. Ensures module enabled. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_page -y >/dev/null 2>&1
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $config = \Drupal::configFactory()->getEditable($theme . ".settings");
  $config->clear("third_party_settings.ui_styles_page");
  if (empty($config->get("third_party_settings"))) { $config->clear("third_party_settings"); }
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ui_styles_page region styles cleared on default theme"
