#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_entity_status): remove the unpublished styles, restoring
# baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $config = \Drupal::configFactory()->getEditable($theme . ".settings");
  $config->clear("third_party_settings.ui_styles_entity_status");
  if (empty($config->get("third_party_settings"))) { $config->clear("third_party_settings"); }
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ui_styles_entity_status unpublished styles cleared"
