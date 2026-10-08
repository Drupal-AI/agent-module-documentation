#!/usr/bin/env bash
# Execution VERIFY (cvcf H1): PASS when the default variation display shows the add-to-cart
# pseudo-field AND its 'combine' third-party setting is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("commerce_product_variation","default","default");
  $has = (bool) $d->getComponent("commerce_variation_cart_form");
  $combine = $d->getThirdPartySetting("commerce_variation_cart_form","combine");
  $ok = $has && ($combine === TRUE);
  print ($ok ? "PASS" : "FAIL")." shown=".var_export($has,TRUE)." combine=".var_export($combine,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
