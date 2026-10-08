#!/usr/bin/env bash
# Execution VERIFY: PASS when printable.settings.save_pdf === TRUE (PDF downloaded as attachment).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("printable.settings")->get("save_pdf");
  print (($v === TRUE || $v === 1 || $v === "1") ? "PASS" : "FAIL") . " save_pdf=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
