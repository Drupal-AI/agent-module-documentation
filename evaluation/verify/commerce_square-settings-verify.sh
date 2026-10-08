#!/usr/bin/env bash
# Execution VERIFY: PASS when sandbox_app_id==sq0idp-BUILD AND sandbox_access_token==EAAA-BUILD.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("commerce_square.settings");
  $id = $c->get("sandbox_app_id"); $tok = $c->get("sandbox_access_token");
  $ok = ($id === "sq0idp-BUILD") && ($tok === "EAAA-BUILD");
  print ($ok ? "PASS" : "FAIL") . " sandbox_app_id=" . var_export($id, TRUE) . " token=" . var_export($tok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
