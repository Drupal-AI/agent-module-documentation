#!/usr/bin/env bash
# Execution RESET: restore default directory (externals) and unmanaged management so verify
# FAILS until the agent changes both. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagecache_external.settings")
    ->set("imagecache_directory", "externals")
    ->set("imagecache_external_management", "unmanaged")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: imagecache_directory=externals, management=unmanaged"
