#!/usr/bin/env bash
# CLEANUP: clear tfa_field back to empty (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sms_phone_number.settings")->set("tfa_field","")->save();' >/dev/null 2>&1
echo "cleanup: sms_phone_number.settings tfa_field cleared"
