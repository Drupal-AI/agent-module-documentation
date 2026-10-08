#!/usr/bin/env bash
# Execution VERIFY: PASS when the HEADER region scripts config contains the required snippet
# marker "HFS head hi 7". exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = (string) \Drupal::config("header_and_footer_scripts.header.settings")->get("scripts");
  print (strpos($s, "HFS head hi 7") !== FALSE ? "PASS" : "FAIL") . " header.scripts=[" . $s . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
