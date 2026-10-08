#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default cache directory. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagecache_external.settings")
    ->set("imagecache_directory", "externals")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: imagecache_directory restored to externals"
