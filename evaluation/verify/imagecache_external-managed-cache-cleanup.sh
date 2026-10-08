#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (externals, unmanaged). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagecache_external.settings")
    ->set("imagecache_directory", "externals")
    ->set("imagecache_external_management", "unmanaged")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: imagecache_directory=externals, management=unmanaged"
