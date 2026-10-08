#!/usr/bin/env bash
# Execution RESET (also CLEANUP): clear sms_phone_number.settings tfa_field so verify FAILS until set. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sms_phone_number.settings")->set("tfa_field","")->save();' >/dev/null 2>&1
echo "reset: sms_phone_number.settings tfa_field cleared"
