#!/usr/bin/env bash
# Execution VERIFY: PASS when the configured directive is DENY. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("x_frame_options_configuration.settings")->get("x_frame_options_configuration.directive");
  $ok = ($d === "DENY");
  print ($ok ? "PASS" : "FAIL") . " directive=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
