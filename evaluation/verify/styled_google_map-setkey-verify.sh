#!/usr/bin/env bash
# Execution VERIFY: PASS when styled_google_map_google_apikey === AIzaSyEVAL-set-me-999 and
# auth method is 1 (API Key). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("styled_google_map.settings");
  $key = $c->get("styled_google_map_google_apikey");
  $m = $c->get("styled_google_map_google_auth_method");
  $ok = ($key === "AIzaSyEVAL-set-me-999" && (string) $m === "1");
  print ($ok ? "PASS" : "FAIL") . " key=" . var_export($key, TRUE) . " auth=" . var_export($m, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
