#!/usr/bin/env bash
# Execution VERIFY: PASS when redirect_back is true in commerce_add_to_cart_link.settings
# (the config the wishlist controller reads). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("commerce_add_to_cart_link.settings")->get("redirect_back");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " redirect_back=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
