#!/usr/bin/env bash
# Execution VERIFY for "remove the www prefix and force HTTPS".
# PASS when httpswww.settings has prefix==='no' and scheme==='https'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("httpswww.settings");
  $prefix = $c->get("prefix");
  $scheme = $c->get("scheme");
  $ok = ($prefix === "no") && ($scheme === "https");
  print ($ok ? "PASS" : "FAIL") . " prefix=" . var_export($prefix, TRUE) . " scheme=" . var_export($scheme, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
