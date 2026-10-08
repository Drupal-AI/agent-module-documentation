#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'large' image style is among wpf.settings styles.disabled
# (after array_filter, matching how ImageFactory reads it). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("wpf.settings")->get("styles.disabled") ?: [];
  $active = array_filter((array) $d);
  $ok = in_array("large", $active, TRUE) || (isset($active["large"]) && $active["large"]);
  print ($ok ? "PASS" : "FAIL") . " disabled=" . json_encode($active) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
