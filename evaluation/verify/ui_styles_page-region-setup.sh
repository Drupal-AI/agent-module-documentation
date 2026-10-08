#!/usr/bin/env bash
# Introspection SETUP (ui_styles_page): apply a UI Styles region style to the default theme's
# 'content' region (extra class ui-styles-eval-region) so an agent can read it back from
# <theme>.settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_page -y >/dev/null 2>&1
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $config = \Drupal::configFactory()->getEditable($theme . ".settings");
  $config->set("third_party_settings.ui_styles_page.regions.content", ["selected" => [], "extra" => "ui-styles-eval-region"]);
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: <default theme>.settings ui_styles_page.regions.content.extra=ui-styles-eval-region"
