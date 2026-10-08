#!/usr/bin/env bash
# Introspection SETUP: turn OFF notify-by-default (private_message.settings.notify_by_default,
# read by the notifier's shouldSend()); default is true. Lets the agent read the live default.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")->set("notify_by_default", FALSE)->save();
' >/dev/null 2>&1
echo "setup: private_message.settings notify_by_default=false"
