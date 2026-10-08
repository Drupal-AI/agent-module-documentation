#!/usr/bin/env bash
# Execution CLEANUP: clear default_service_id back to baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("commerce_stock.service_manager"); $c->clear("default_service_id")->save();' >/dev/null 2>&1
echo "cleanup: default_service_id cleared (baseline)"
