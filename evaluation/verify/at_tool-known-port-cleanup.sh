#!/usr/bin/env bash
# Introspection CLEANUP: remove the nested 'settings' key from the active theme's config,
# restoring its original state (no such key). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::config("system.theme")->get("default");
  \Drupal::configFactory()->getEditable("$t.settings")->clear("settings")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: active theme settings key removed"
