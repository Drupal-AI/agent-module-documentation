#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_service_worker.config")->set("cache_version","1")->save();' >/dev/null 2>&1
echo "cleanup: pwa_service_worker.config cache_version=1 (default)"
