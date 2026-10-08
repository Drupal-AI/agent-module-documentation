#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_page): remove the region style added by setup, restoring
# baseline (no ui_styles_page third-party settings on the theme). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $config = \Drupal::configFactory()->getEditable($theme . ".settings");
  $config->clear("third_party_settings.ui_styles_page");
  if (empty($config->get("third_party_settings"))) { $config->clear("third_party_settings"); }
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ui_styles_page region styles cleared from default theme settings"
