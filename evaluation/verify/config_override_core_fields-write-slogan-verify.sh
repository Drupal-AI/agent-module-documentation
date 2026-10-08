#!/usr/bin/env bash
# Execution VERIFY: PASS when system.site:slogan === 'COCF Verified Slogan' (the config object
# and key the site-info Slogan field maps to). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::configFactory()->getEditable("system.site")->get("slogan");
  $ok = ($v === "COCF Verified Slogan");
  print ($ok ? "PASS" : "FAIL") . " slogan=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
