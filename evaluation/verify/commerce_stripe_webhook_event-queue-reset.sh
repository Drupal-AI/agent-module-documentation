#!/usr/bin/env bash
# Execution RESET: force queue processing OFF (verify FAILS until the agent enables it).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stripe_webhook_event.settings")->set("queue", FALSE)->save();' >/dev/null 2>&1
echo "reset: queue=false"
