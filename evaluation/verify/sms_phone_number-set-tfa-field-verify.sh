#!/usr/bin/env bash
# Execution VERIFY: PASS when sms_phone_number.settings tfa_field == field_spn_mobile. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("sms_phone_number.settings")->get("tfa_field");
  $ok = ($v === "field_spn_mobile");
  print ($ok?"PASS":"FAIL")." tfa_field=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
