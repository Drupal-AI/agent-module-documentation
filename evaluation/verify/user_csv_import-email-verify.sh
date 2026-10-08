#!/usr/bin/env bash
# Execution VERIFY: PASS when the saved import config selects the admin-created welcome email.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("user_csv_import.importconfig")->get("registration_email_type");
  $ok = ($v === "register_admin_created");
  print ($ok ? "PASS" : "FAIL") . " registration_email_type=" . var_export($v,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
