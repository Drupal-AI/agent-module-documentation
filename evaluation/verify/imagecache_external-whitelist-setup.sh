#!/usr/bin/env bash
# Introspection SETUP: enable the host whitelist with known hosts. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagecache_external.settings")
    ->set("imagecache_external_use_whitelist", TRUE)
    ->set("imagecache_external_hosts", "example.com trusted.test")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: whitelist on, hosts=example.com trusted.test"
