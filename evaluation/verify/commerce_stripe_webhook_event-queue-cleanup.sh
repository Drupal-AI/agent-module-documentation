#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stripe_webhook_event.settings")->set("queue", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: queue=false"
