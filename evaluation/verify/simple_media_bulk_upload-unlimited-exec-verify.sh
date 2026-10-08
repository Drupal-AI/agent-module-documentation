#!/usr/bin/env bash
# Execution VERIFY: PASS when max_files === 0 (unlimited). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("simple_media_bulk_upload.settings")->get("max_files");
  print (((int)$v === 0) ? "PASS" : "FAIL") . " max_files=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
