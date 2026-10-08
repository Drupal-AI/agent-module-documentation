#!/usr/bin/env bash
# Execution VERIFY: PASS when crowdsec.settings plugins.whisper.bucket_capacity === 25. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("crowdsec.settings")->get("plugins.whisper.bucket_capacity");
  $ok = ((int) $v === 25);
  print ($ok ? "PASS" : "FAIL") . " bucket_capacity=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
