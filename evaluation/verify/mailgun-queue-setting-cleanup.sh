#!/usr/bin/env bash
# Introspection CLEANUP: restore Mailgun use_queue to shipped default false. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mailgun.settings")->set("use_queue", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: mailgun.settings use_queue=false (default restored)"
