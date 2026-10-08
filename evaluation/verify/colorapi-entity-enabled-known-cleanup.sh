#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline enable_color_entity=false (default). Also removes any
# stray colorapi_color config so the switch can be turned off cleanly. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  foreach ($cf->listAll("colorapi.colorapi_color.") as $name) { $cf->getEditable($name)->delete(); }
  $cf->getEditable("colorapi.settings")->set("enable_color_entity", 0)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: colorapi.settings.enable_color_entity = 0 (baseline)"
