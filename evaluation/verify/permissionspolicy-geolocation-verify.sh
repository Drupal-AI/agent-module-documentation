#!/usr/bin/env bash
# Execution VERIFY: PASS when geolocation is disabled for everyone (base 'none') in the
# enforce policy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $base = \Drupal::config("permissionspolicy.settings")->get("enforce.features.geolocation.base");
  $ok = ($base === "none");
  print ($ok ? "PASS" : "FAIL") . " geolocation.base=" . var_export($base, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
