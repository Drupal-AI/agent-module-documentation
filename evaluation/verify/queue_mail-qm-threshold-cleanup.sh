#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default threshold (50).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("queue_mail.settings")->set("threshold",50)->save();' >/dev/null 2>&1
echo "cleanup: threshold restored to 50"
