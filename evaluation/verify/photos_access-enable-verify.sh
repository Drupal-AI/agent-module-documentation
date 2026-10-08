#!/usr/bin/env bash
# Execution VERIFY: PASS when album privacy is enabled for the photos album type, i.e.
# photos.settings:photos_access_photos is truthy (1). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("photos.settings")->get("photos_access_photos");
  $ok = ((int) $v === 1);
  print ($ok ? "PASS" : "FAIL") . " photos_access_photos=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
