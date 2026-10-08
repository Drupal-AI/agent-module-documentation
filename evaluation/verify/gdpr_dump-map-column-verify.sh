#!/usr/bin/env bash
# Execution VERIFY: PASS when gdpr_dump.table_map maps the users_field_data.mail column to the
# email_anonymizer plugin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $map = \Drupal::config("gdpr_dump.table_map")->get("mapping") ?: [];
  $v = $map["users_field_data"]["mail"] ?? "";
  $ok = ($v === "email_anonymizer");
  print ($ok ? "PASS" : "FAIL") . " users_field_data.mail=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
