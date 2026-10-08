#!/usr/bin/env bash
# Execution VERIFY: PASS when cookiebot_cbid === 11112222-3333-4444-5555-666677778888.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("cookiebot.settings")->get("cookiebot_cbid");
  print (($v === "11112222-3333-4444-5555-666677778888") ? "PASS" : "FAIL") . " cbid=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
