#!/usr/bin/env bash
# Execution VERIFY: PASS when system.site:page.403 === '/cocf-403' (the config object/key the
# site-info '403 page' field maps to). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::configFactory()->getEditable("system.site")->get("page.403");
  $ok = ($v === "/cocf-403");
  print ($ok ? "PASS" : "FAIL") . " page403=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
