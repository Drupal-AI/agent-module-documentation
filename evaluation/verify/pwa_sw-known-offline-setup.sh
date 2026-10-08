#!/usr/bin/env bash
# Introspection SETUP: set pwa_service_worker.config offline_page to '/maintenance'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_service_worker.config")->set("offline_page","/maintenance")->save();' >/dev/null 2>&1
echo "setup: pwa_service_worker.config offline_page=/maintenance"
