#!/usr/bin/env bash
# Execution CLEANUP: restore Mailgun test_mode to shipped default false. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mailgun.settings")->set("test_mode", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: mailgun.settings test_mode=false (default restored)"
