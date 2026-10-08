#!/usr/bin/env bash
# Execution VERIFY: PASS when multiselect.settings multiselect.widths === 320 (int).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("multiselect.settings")->get("multiselect.widths");
  print (((int) $v === 320) ? "PASS" : "FAIL") . " widths=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
