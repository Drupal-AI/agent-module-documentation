#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore offline_page to default '/offline' so verify FAILS until agent
# sets '/sorry-offline'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_service_worker.config")->set("offline_page","/offline")->save();' >/dev/null 2>&1
echo "reset: pwa_service_worker.config offline_page=/offline (default)"
