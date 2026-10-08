#!/usr/bin/env bash
# Execution VERIFY: PASS when photos.settings:photos_display_list_imagesize === 'thumbnail'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("photos.settings")->get("photos_display_list_imagesize");
  $ok = ($v === "thumbnail");
  print ($ok ? "PASS" : "FAIL") . " photos_display_list_imagesize=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
