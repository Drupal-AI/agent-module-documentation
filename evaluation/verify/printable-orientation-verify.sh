#!/usr/bin/env bash
# Execution VERIFY: PASS when printable.settings.page_orientation === 'Landscape'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("printable.settings")->get("page_orientation");
  print (($v === "Landscape") ? "PASS" : "FAIL") . " page_orientation=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
