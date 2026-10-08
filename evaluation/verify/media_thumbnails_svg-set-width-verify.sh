#!/usr/bin/env bash
# Execution VERIFY: PASS when the SVG thumbnail width (media_thumbnails.settings.width) === 300.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("media_thumbnails.settings")->get("width");
  print ((int)$w === 300 ? "PASS" : "FAIL")." width=".var_export($w,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
