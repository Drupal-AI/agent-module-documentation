#!/usr/bin/env bash
# PASS when twigsuggest.settings.alternate_ds_suggestions is TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("twigsuggest.settings")->get("alternate_ds_suggestions");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " alternate_ds_suggestions=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
