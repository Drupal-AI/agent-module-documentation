#!/usr/bin/env bash
# Execution VERIFY: PASS when simplelogin.settings button_background === TRUE AND wrapper_width
# === 500. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("simplelogin.settings");
  $b = $c->get("button_background"); $w = $c->get("wrapper_width");
  $ok = ($b===TRUE) && ((int)$w===500);
  print ($ok ? "PASS" : "FAIL") . " button_background=" . var_export($b, TRUE) . " wrapper_width=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
