#!/usr/bin/env bash
# Execution VERIFY: PASS when coi.settings overridden_value.secrets === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("coi.settings")->get("overridden_value.secrets");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " secrets=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
