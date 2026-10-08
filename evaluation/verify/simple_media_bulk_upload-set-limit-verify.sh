#!/usr/bin/env bash
# Execution VERIFY: PASS when simple_media_bulk_upload.settings:max_files === 100.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("simple_media_bulk_upload.settings")->get("max_files");
  print (((int)$v === 100) ? "PASS" : "FAIL") . " max_files=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
