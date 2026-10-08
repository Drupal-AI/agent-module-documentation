#!/usr/bin/env bash
# Introspection CLEANUP: restore whitelist defaults (off, empty hosts). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagecache_external.settings")
    ->set("imagecache_external_use_whitelist", FALSE)
    ->set("imagecache_external_hosts", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: whitelist restored to off/empty"
