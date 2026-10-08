#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore skip_waiting to default FALSE so verify FAILS until agent enables
# it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_service_worker.config")->set("skip_waiting",FALSE)->save();' >/dev/null 2>&1
echo "reset: pwa_service_worker.config skip_waiting=FALSE (default)"
