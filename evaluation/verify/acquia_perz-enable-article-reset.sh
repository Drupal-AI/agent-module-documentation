#!/usr/bin/env bash
# Execution RESET/CLEANUP: clear the acquia_perz personalization opt-in map back to the shipped
# default (view_modes: {}), so verify FAILS until the agent opts Article/default in. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("acquia_perz.entity_config");
  $c->set("view_modes", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: acquia_perz.entity_config view_modes cleared"
