#!/usr/bin/env bash
# Execution VERIFY: PASS when media_alias_display.settings kill_switch === TRUE. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("media_alias_display.settings")->get("kill_switch");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " kill_switch=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
