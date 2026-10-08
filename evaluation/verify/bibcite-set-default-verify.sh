#!/usr/bin/env bash
# Execution VERIFY: PASS when bibcite.settings default_style is 'apa' and convert_urls is TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bibcite.settings");
  $ok = ($c->get("default_style") === "apa") && ($c->get("convert_urls") === TRUE);
  print ($ok ? "PASS" : "FAIL") . " default_style=" . var_export($c->get("default_style"), TRUE) . " convert_urls=" . var_export($c->get("convert_urls"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
