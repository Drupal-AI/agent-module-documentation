#!/usr/bin/env bash
# Introspection SETUP: put the active/default theme into development mode with a known LiveReload
# port (12345) in the theme settings config that at_tool reads, so an agent can read it back.
# Adds a nested 'settings' key that cleanup fully removes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::config("system.theme")->get("default");
  \Drupal::configFactory()->getEditable("$t.settings")
    ->set("settings", ["enable_devel" => 1, "enable_live_reload" => 1, "live_reload_port" => "12345"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: active theme settings.live_reload_port=12345 (devel+livereload on)"
