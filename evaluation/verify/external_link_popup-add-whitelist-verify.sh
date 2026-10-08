#!/usr/bin/env bash
# Execution VERIFY for "add trusted-charity.test to the external_link_popup trusted-domains
# whitelist". PASS when external_link_popup.settings whitelist contains trusted-charity.test.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $wl = (string) \Drupal::config("external_link_popup.settings")->get("whitelist");
  $ok = (strpos($wl, "trusted-charity.test") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " whitelist=" . str_replace("\n", ",", $wl) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
