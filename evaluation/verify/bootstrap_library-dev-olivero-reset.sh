#!/usr/bin/env bash
# Execution RESET: force bootstrap_library back to the minified local build with no theme
# restriction, so verify FAILS until the agent switches to the source build limited to the
# Olivero theme. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("minimized.options", TRUE)
    ->set("theme.visibility", TRUE)
    ->set("theme.themes", "")
    ->set("cdn.bootstrap", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: bootstrap_library minimized.options=1 (minified), no theme restriction, local files"
