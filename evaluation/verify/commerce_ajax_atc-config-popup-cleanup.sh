#!/usr/bin/env bash
# Execution CLEANUP: delete commerce_ajax_atc.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_ajax_atc.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: commerce_ajax_atc.settings deleted"
