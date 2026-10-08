#!/usr/bin/env bash
# Live-state verification: genpass.settings:genpass_override_core is FALSE
# (core DefaultPasswordGenerator no longer overridden by Genpass).
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("genpass.settings")->get("genpass_override_core");
  $off = ($v === FALSE || $v === 0 || $v === "0");
  print ($off ? "PASS" : "FAIL") . " genpass_override_core=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
