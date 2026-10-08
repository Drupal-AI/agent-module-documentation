#!/usr/bin/env bash
# Execution RESET: delete commerce_ajax_atc.settings so verify FAILS until the agent configures
# the pop-up. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_ajax_atc.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: commerce_ajax_atc.settings deleted"
