#!/usr/bin/env bash
# Introspection SETUP: enable Simple Less compilation, developer mode AND watch mode in
# system.performance, so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.performance")
    ->set("ipless", ["enabled" => TRUE, "modedev" => TRUE, "sourcemap" => FALSE, "watch_mode" => TRUE])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: system.performance ipless enabled+modedev+watch_mode = TRUE"
