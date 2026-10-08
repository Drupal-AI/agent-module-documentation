#!/usr/bin/env bash
# Execution VERIFY: PASS when helper.settings enabled.core_text_textarea_widgets is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("helper.settings")->get("enabled") ?: [];
  $v = $e["core_text_textarea_widgets"] ?? NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ((($ok) ? "PASS" : "FAIL")." core_text_textarea_widgets=".var_export($v,true)."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
