#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_service_worker.config")->set("offline_page","/offline")->save();' >/dev/null 2>&1
echo "cleanup: pwa_service_worker.config offline_page=/offline (default)"
