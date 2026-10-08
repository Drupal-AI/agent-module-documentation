#!/usr/bin/env bash
# Introspection SETUP (ui_styles_entity_status): set unpublished-entity styles on the default
# theme (extra class ui-styles-eval-unpub) so an agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_entity_status -y >/dev/null 2>&1
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $config = \Drupal::configFactory()->getEditable($theme . ".settings");
  $config->set("third_party_settings.ui_styles_entity_status.unpublished", ["selected" => [], "extra" => "ui-styles-eval-unpub"]);
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: <default theme>.settings ui_styles_entity_status.unpublished.extra=ui-styles-eval-unpub"
