#!/usr/bin/env bash
# Introspection SETUP: set sms_phone_number.settings tfa_field=field_spn_tfa. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sms_phone_number.settings")->set("tfa_field","field_spn_tfa")->save();' >/dev/null 2>&1
echo "setup: sms_phone_number.settings tfa_field=field_spn_tfa"
