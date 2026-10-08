#!/usr/bin/env bash
# Introspection SETUP: seed dropsolid_purge.config with site_name 'DocSite'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dropsolid_purge.config")
    ->set("site_name", "DocSite")
    ->set("site_environment", "docs")
    ->set("site_group", "DocGroup")
    ->save();
' >/dev/null 2>&1
echo "setup: dropsolid_purge.config site_name=DocSite"
