#!/usr/bin/env bash
# Execution VERIFY: PASS when csrf_token.roles contains 'content_editor' (protects that role's
# wishlist links via the shared token service). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $roles = \Drupal::config("commerce_add_to_cart_link.settings")->get("csrf_token.roles") ?: [];
  $ok = in_array("content_editor", $roles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " roles=" . json_encode($roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
