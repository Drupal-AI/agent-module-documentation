#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (retention 2592000, queue false).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_stripe_webhook_event.settings")
    ->set("retention_time", 2592000)->set("queue", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: retention_time=2592000, queue=false"
