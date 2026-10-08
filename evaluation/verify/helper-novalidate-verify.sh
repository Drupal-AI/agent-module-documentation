#!/usr/bin/env bash
# Execution VERIFY: PASS when helper.settings enabled.core_form_novalidate is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("helper.settings")->get("enabled") ?: [];
  $v = $e["core_form_novalidate"] ?? NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ((($ok) ? "PASS" : "FAIL")." core_form_novalidate=".var_export($v,true)."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
