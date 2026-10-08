#!/usr/bin/env bash
# Live-state verification for "protect ALL forms with a 4-second time limit".
# Reads honeypot.settings from the running site and requires:
#   protect_all_forms === TRUE   (site-wide protection on)
#   time_limit        === 4      (minimum submit time set to 4 seconds)
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("honeypot.settings");
  $all = $c->get("protect_all_forms");
  $tl  = $c->get("time_limit");
  $ok  = ($all === TRUE && (int) $tl === 4);
  print ($ok ? "PASS" : "FAIL") . " protect_all_forms=" . var_export($all, TRUE) . " time_limit=" . var_export($tl, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
