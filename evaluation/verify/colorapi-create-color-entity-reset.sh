#!/usr/bin/env bash
# Execution RESET: remove any cai_red Color config and turn the Color entity type OFF (baseline),
# so verify FAILS until the agent enables the type and creates the entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $cf->getEditable("colorapi.colorapi_color.cai_red")->delete();
  $cf->getEditable("colorapi.settings")->set("enable_color_entity", 0)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cai_red absent, enable_color_entity=0"
