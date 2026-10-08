#!/usr/bin/env bash
# Introspection SETUP: turn Simple Less compilation ON but developer mode OFF in system.performance,
# so an inspecting agent can read the live ipless.* flags. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.performance")
    ->set("ipless", ["enabled" => TRUE, "modedev" => FALSE, "sourcemap" => FALSE, "watch_mode" => FALSE])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: system.performance ipless.enabled=TRUE, modedev=FALSE"
