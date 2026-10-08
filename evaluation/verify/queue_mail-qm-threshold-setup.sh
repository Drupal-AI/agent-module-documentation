#!/usr/bin/env bash
# Introspection SETUP: set a known retry threshold.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("queue_mail.settings")->set("threshold",10)->save();' >/dev/null 2>&1
echo "setup: queue_mail retry threshold=10"
