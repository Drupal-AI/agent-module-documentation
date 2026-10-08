#!/usr/bin/env bash
# Execution CLEANUP: delete the cai_red Color config and restore enable_color_entity=false. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $cf->getEditable("colorapi.colorapi_color.cai_red")->delete();
  $cf->getEditable("colorapi.settings")->set("enable_color_entity", 0)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cai_red removed, enable_color_entity=0 (baseline)"
