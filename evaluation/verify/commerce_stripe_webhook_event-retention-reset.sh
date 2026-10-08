#!/usr/bin/env bash
# Execution RESET: force retention_time to the shipped default 2592000 (verify FAILS until the
# agent changes it to 86400).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stripe_webhook_event.settings")->set("retention_time", 2592000)->save();' >/dev/null 2>&1
echo "reset: retention_time=2592000"
