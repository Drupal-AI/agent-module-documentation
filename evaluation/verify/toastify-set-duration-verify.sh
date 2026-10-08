#!/usr/bin/env bash
# Execution VERIFY: PASS when toastify.settings status.duration === 10000. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("toastify.settings")->get("status.duration");
  print (($v === 10000) ? "PASS" : "FAIL") . " status.duration=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
