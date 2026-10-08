#!/usr/bin/env bash
# Execution RESET: remove the nested 'settings' key from the active theme's config so verify
# FAILS until the agent enables devel + livereload with port 9000. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::config("system.theme")->get("default");
  \Drupal::configFactory()->getEditable("$t.settings")->clear("settings")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: active theme has no livereload settings"
