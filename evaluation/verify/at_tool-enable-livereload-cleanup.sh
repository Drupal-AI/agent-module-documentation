#!/usr/bin/env bash
# Execution CLEANUP: remove the nested settings key from the active theme, restoring baseline. Exit 0.
# 
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::config("system.theme")->get("default");
  \Drupal::configFactory()->getEditable("$t.settings")->clear("settings")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: active theme livereload settings removed"
