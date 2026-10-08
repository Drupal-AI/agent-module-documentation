#!/usr/bin/env bash
# Execution RESET: force Mailgun test_mode OFF so verify FAILS until the agent enables test mode. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mailgun.settings")->set("test_mode", FALSE)->save();' >/dev/null 2>&1
echo "reset: mailgun.settings test_mode=false"
