#!/usr/bin/env bash
# Execution VERIFY: PASS when the add_to_cart_link pseudo field is shown (component present in a
# visible region) on commerce_product.default.default. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("commerce_product.default.default");
  $c = $d ? $d->getComponent("add_to_cart_link") : NULL;
  $ok = is_array($c) && (($c["region"] ?? "hidden") !== "hidden");
  print ($ok ? "PASS" : "FAIL") . " component=" . var_export($c, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
