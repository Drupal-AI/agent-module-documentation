#!/usr/bin/env bash
# Introspection SETUP: set distinctive commerce_stripe_webhook_event.settings values (retention
# 111111 seconds, queue enabled) so the agent can read them back. Baseline is 2592000 / false.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_stripe_webhook_event.settings")
    ->set("retention_time", 111111)->set("queue", TRUE)->save();
' >/dev/null 2>&1
echo "setup: retention_time=111111, queue=true"
