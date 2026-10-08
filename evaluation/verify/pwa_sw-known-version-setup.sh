#!/usr/bin/env bash
# Introspection SETUP: bump cache_version to '7' (default '1'). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_service_worker.config")->set("cache_version","7")->save();' >/dev/null 2>&1
echo "setup: pwa_service_worker.config cache_version=7"
