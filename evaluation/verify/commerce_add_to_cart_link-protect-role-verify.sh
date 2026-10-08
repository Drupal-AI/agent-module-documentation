#!/usr/bin/env bash
# Execution VERIFY: PASS when csrf_token.roles in commerce_add_to_cart_link.settings contains
# 'authenticated'. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $roles = \Drupal::config("commerce_add_to_cart_link.settings")->get("csrf_token.roles") ?: [];
  $ok = in_array("authenticated", $roles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " roles=" . json_encode($roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
