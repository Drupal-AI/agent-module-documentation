#!/usr/bin/env bash
# Execution VERIFY: PASS when media_pdf_thumbnail.settings destination_uri_public ==
# public://pdf-thumbs. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("media_pdf_thumbnail.settings")->get("destination_uri_public");
  $ok = ($v === "public://pdf-thumbs");
  print ($ok ? "PASS" : "FAIL") . " destination_uri_public=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
