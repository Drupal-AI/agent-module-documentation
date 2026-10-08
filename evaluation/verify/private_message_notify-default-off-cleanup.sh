#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default notify_by_default=true. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")->set("notify_by_default", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: private_message.settings notify_by_default restored to true"
