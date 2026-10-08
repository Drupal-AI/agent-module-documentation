#!/usr/bin/env bash
# Execution VERIFY: PASS when the FOOTER region scripts config contains the required snippet
# marker "HFS goodbye 42". exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = (string) \Drupal::config("header_and_footer_scripts.footer.settings")->get("scripts");
  print (strpos($s, "HFS goodbye 42") !== FALSE ? "PASS" : "FAIL") . " footer.scripts=[" . $s . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
