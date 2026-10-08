#!/usr/bin/env bash
# Execution VERIFY: PASS when wpf.settings quality === 60. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("wpf.settings")->get("quality");
  $ok = ((int) $v === 60);
  print ($ok ? "PASS" : "FAIL") . " quality=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
