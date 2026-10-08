#!/usr/bin/env bash
# Execution VERIFY: PASS when pdf_api.dom_pdf.settings dpi === 300 AND defaultFont === 'sans-serif'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("pdf_api.dom_pdf.settings");
  $dpi = $c->get("dpi"); $font = $c->get("defaultFont");
  $ok = ($dpi === 300 && $font === "sans-serif");
  print ($ok ? "PASS" : "FAIL") . " dpi=" . var_export($dpi, TRUE) . " font=" . var_export($font, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
