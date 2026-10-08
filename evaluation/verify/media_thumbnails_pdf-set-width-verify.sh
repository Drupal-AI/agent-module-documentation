#!/usr/bin/env bash
# Execution VERIFY: PASS when media_thumbnails.settings width === 250 (the width the PDF plugin
# will scale thumbnails to). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("media_thumbnails.settings")->get("width");
  print (($w === 250) ? "PASS" : "FAIL") . " width=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
