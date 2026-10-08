#!/usr/bin/env bash
# Execution VERIFY: PASS when commerce_cart_redirection.settings sends the 'default' product
# variation bundle to the CART page (redirection_route_path === 'cart' and product_bundles.default
# is selected, negate off). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("commerce_cart_redirection.settings");
  $path = $c->get("redirection_route_path");
  $b = $c->get("product_bundles") ?: [];
  $neg = $c->get("negate_product_bundles");
  $selected = (isset($b["default"]) && $b["default"] !== 0 && $b["default"] !== FALSE);
  $ok = ($path === "cart" && $selected && !$neg);
  print ($ok ? "PASS" : "FAIL") . " path=" . var_export($path, TRUE) . " default=" . var_export($b["default"] ?? NULL, TRUE) . " negate=" . var_export($neg, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
