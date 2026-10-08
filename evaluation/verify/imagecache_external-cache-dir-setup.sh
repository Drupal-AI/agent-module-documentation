#!/usr/bin/env bash
# Introspection SETUP: set a known cache directory so the agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagecache_external.settings")
    ->set("imagecache_directory", "ice_probe_ext")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imagecache_directory=ice_probe_ext"
