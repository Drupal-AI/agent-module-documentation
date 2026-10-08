#!/usr/bin/env bash
# Execution VERIFY: PASS when ib_dam_media.settings.upload_location === public://ib-dam-files.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ib_dam_media.settings")->get("upload_location");
  $ok = ($v === "public://ib-dam-files");
  print ($ok ? "PASS" : "FAIL") . " upload_location=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
