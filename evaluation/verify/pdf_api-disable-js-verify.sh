#!/usr/bin/env bash
# Execution VERIFY: PASS when pdf_api.dom_pdf.settings isJavascriptEnabled === FALSE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pdf_api.dom_pdf.settings")->get("isJavascriptEnabled");
  $ok = ($v === FALSE);
  print ($ok ? "PASS" : "FAIL") . " isJavascriptEnabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
