#!/usr/bin/env bash
# Execution RESET (ui_styles_entity_status): clear the unpublished styles on the default theme
# so verify FAILS until the agent sets them. Ensures module enabled. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_entity_status -y >/dev/null 2>&1
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $config = \Drupal::configFactory()->getEditable($theme . ".settings");
  $config->clear("third_party_settings.ui_styles_entity_status");
  if (empty($config->get("third_party_settings"))) { $config->clear("third_party_settings"); }
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ui_styles_entity_status unpublished styles cleared on default theme"
